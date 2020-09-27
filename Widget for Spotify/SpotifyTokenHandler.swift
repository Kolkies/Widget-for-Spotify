//
//  SpotifyHandler.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 25/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SpotifyTokenHandler: ObservableObject {
    @Published var authState: AuthState = .UNKOWN
    static let shared = SpotifyTokenHandler()
    
    private init(){
        
    }
    
    /**
     Stores given tokens in database
     
     - Parameter accessToken: the given acces Token
     - Parameter refreshToken: the given refresh Token
     */
    static func storeTokens(accessToken: String, refreshToken: String){
        print("Setting up tokens. accessToken: \(accessToken) &&||&& refreshToken: \(refreshToken)")
        let userDefaults = UserDefaults.init(suiteName: "group.dev.netlob.widget-for-spotify")
        userDefaults?.setValue(accessToken, forKey: "accessToken")
        userDefaults?.setValue(refreshToken, forKey: "refreshToken")
    }
    
    /**
     Returns the stored accessToken from database
            
     - Returns: The optional access Token from database.
     */
    static func accessToken() -> String?{
        let userDefaults = UserDefaults.init(suiteName: "group.dev.netlob.widget-for-spotify")
        let token = userDefaults?.string(forKey: "accessToken")
        return token
    }
    
    /**
     Refreshes the accessToken using the refreshToken stored in database.
     This function should be called on startup to get a functioning accessToken and set a timeout to make sure the accessToken gets refreshed
     */
    static func refreshToken() -> Void{
        // Retrieve token for userdefaults database
        let userDefaults = UserDefaults.init(suiteName: "group.dev.netlob.widget-for-spotify")
        let refreshToken = userDefaults?.string(forKey: "refreshToken")
        // Check if a refresh token is present
        if(refreshToken == "" || refreshToken == nil){
            print("unable to refresh token, since there is no refreshtoken")
            SpotifyTokenHandler.shared.authState = .NOTSIGNEDID
            return
        }
        
        AF.request("https://spotifywidgettokenservice.herokuapp.com/api/refresh_token", method: .post, parameters: ["refresh_token": refreshToken]).responseJSON { response in
            if response.data != nil {
                let json = try? JSON(data: response.data!)
                let token = json?["access_token"].string
                print("Refreshed token with " + (token ?? ""))
                if token != nil {
                    userDefaults?.setValue(token, forKey: "accessToken")
                    SpotifyTokenHandler.shared.authState = .SIGNEDIN
                    
                    let queue = DispatchQueue.global(qos: .background)

                    // Plan a refresh after the token expires.
                    queue.asyncAfter(deadline: .now() + (json?["expires_in"].doubleValue)!) {
                        SpotifyTokenHandler.refreshToken()
                    }
                } else {
                    SpotifyTokenHandler.shared.authState = .NOTSIGNEDID
                }
            }
        }
    }
}

enum AuthState {
    case UNKOWN
    case SIGNEDIN
    case NOTSIGNEDID
    case INVALID
}
