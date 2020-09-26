//
//  AppDelegate.swift
//  Widget for Spotify
//
//  Created by Sjoerd Bolten on 23/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate, SPTSessionManagerDelegate, ObservableObject {
    
    @Published var spotifySession: SPTSession? = nil
    
    @Published var currentPlayingSong: SPTAppRemoteTrack? = nil

    let SpotifyClientID = "280335d60c1a4ae8a4d3f5ff344e8e16"
    let SpotifyRedirectURL = URL(string: "widget-for-spotify://spotify-login-callback")!
    var accessToken: String = "";

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
       appRemote.connectionParameters.accessToken = self.sessionManager.session?.accessToken
      appRemote.delegate = self
      return appRemote
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.absoluteString)
        self.sessionManager.application(app, open: url, options: options)
        
        return true
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
      print("failed")
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      // Connection was successful, you can begin issuing commands
        print("AppRemote succesfully connected")
      self.appRemote.playerAPI?.delegate = self
      self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
        if let result = result {
            print(result)
        }
        if let error = error {
          debugPrint(error.localizedDescription)
        }
      })
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("Track name: %@", playerState.track.name)
        self.currentPlayingSong = playerState.track
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Succesfully logged in")
        DispatchQueue.main.async{
            self.spotifySession = session
        }
        print("Refresh Token: \(session.refreshToken)")
        SpotifyTokenHandler.storeTokens(accessToken: session.accessToken, refreshToken: session.refreshToken)
        SpotifyTokenHandler.refreshToken()
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("session manager error " + error.localizedDescription)
    }
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://spotifywidgettokenservice.herokuapp.com/api/token"),
           let tokenRefreshURL = URL(string: "https://spotifywidgettokenservice.herokuapp.com/api/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = nil
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
       return manager
    }()
    
    let requestedScopes: SPTScope = [.appRemoteControl, .userReadCurrentlyPlaying]
    
    func signin(){
        self.sessionManager.alwaysShowAuthorizationDialog = true
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        sessionManager.renewSession()
    }
    
    func connect() {
        if(spotifySession != nil){
            self.appRemote.authorizeAndPlayURI("")
            self.appRemote.connect()
        }else{
            print("Spotify session not initialized")
        }
      
    }
}

struct spotifyData: Codable{
    var name: String
}

