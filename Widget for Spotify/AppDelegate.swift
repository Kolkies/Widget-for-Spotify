//
//  AppDelegate.swift
//  Widget for Spotify
//
//  Created by Sjoerd Bolten on 23/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import UIKit
import WidgetKit
import BackgroundTasks
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate, ObservableObject {
    
    @Published var spotifySession: SPTSession? = nil

    let SpotifyClientID = "280335d60c1a4ae8a4d3f5ff344e8e16"
    let SpotifyRedirectURL = URL(string: "widget-for-spotify://spotify-login-callback")!

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        WidgetCenter.shared.reloadAllTimelines()
        
        // Override point for customization after application launch.
        let item = launchOptions?[.shortcutItem]
        if let shortcut = item as? UIApplicationShortcutItem {
            if(shortcut.type == "dev.netlob.widget-for-spotify-refreshwidget"){
                WidgetCenter.shared.reloadAllTimelines()
                return true
            } else {
                return false
            }
        }
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
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem) -> Bool{
        if(shortcutItem.type == "dev.netlob.widget-for-spotify-refreshwidget"){
            WidgetCenter.shared.reloadAllTimelines()
            return true
        } else {
            return false
        }
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.absoluteString)
        self.sessionManager.application(app, open: url, options: options)
        
        return true
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Succesfully logged in")
        DispatchQueue.main.async{
            self.spotifySession = session
        }
        print("Refresh Token: \(session.refreshToken)")
        SpotifyTokenHandler.storeTokens(accessToken: session.accessToken, refreshToken: session.refreshToken)
        DispatchQueue.main.async {
            SpotifyTokenHandler.shared.authState = .SIGNEDIN
        }
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
    
    let requestedScopes: SPTScope = [.appRemoteControl, .userReadCurrentlyPlaying, .userReadPlaybackState]
    
    func signin(){
        self.sessionManager.alwaysShowAuthorizationDialog = true
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        sessionManager.renewSession()
    }
}

