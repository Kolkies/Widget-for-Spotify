//
//  SpotifyData.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

/// Handles all data retrieved from spotify.
/// Is a singleton. In order to acces use SpotifyData.shared, DO NOT create a new instance
class SpotifyData: ObservableObject {
    static var shared = SpotifyData()
    
    @Published var personInfo: PersonInfo?
    
    private init(){
        
        // All methods that should run on startup since we need to get their info
        getPersonInfo()
    }
    
    /// Sets the personInfo property
    func getPersonInfo() -> Void {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SpotifyTokenHandler.accessToken() ?? "")"
        ]
        
        AF.request("https://api.spotify.com/v1/me", headers: headers).response { response in
            if response.data != nil {
                if let user = try? JSONDecoder().decode(PersonInfo.self, from: response.data!){
                    self.personInfo = user
                    print("Stored Person Data")
                }
            }
        }
    }
}
