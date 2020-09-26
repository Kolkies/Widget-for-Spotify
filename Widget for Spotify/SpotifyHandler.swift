//
//  SpotifyHandler.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 25/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

class SpotifyTokenHandler: ObservableObject {
    static func storeTokens(accessToken: String, refreshToken: String){
        print("Setting up tokens. accessToken: \(accessToken) &&||&& refreshToken: \(refreshToken)")
        let userDefaults = UserDefaults.init(suiteName: "SpotifyWidget")
        userDefaults?.setValue(accessToken, forKey: "accessToken")
        userDefaults?.setValue(refreshToken, forKey: "refreshToken")
    }
    
    static func accessToken()
    
    static func refreshToken(){
        // Retrieve token for userdefaults database
        let userDefaults = UserDefaults.init(suiteName: "SpotifyWidget")
        let refreshToken = userDefaults?.string(forKey: "refreshToken")
        // Check if a refresh token is present
        if(refreshToken == ""){
            print("unable to refresh token, since there is no refreshtoken")
            return
        }
        
        let parameters = "grant_type=refresh_token&refresh_token=\(String(describing: refreshToken))"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/api/token")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
            }

            task.resume()
        }
    }
}
