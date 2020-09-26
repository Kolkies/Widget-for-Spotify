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
                let json = try? JSON(data: response.data!)
                let userData = json?["access_token"].string
                if let user = try? JSONDecoder().decode(PersonInfo.self, from: response.data!){
                    self.personInfo = user
                    print("Stored Person Data")
                }
            }
        }
    }
}

/// All structs that define spotify data
/// For more info: https://developer.spotify.com/documentation/web-api/reference/users-profile/get-current-users-profile/
struct PersonInfo: Codable {
    var country: String?
    var display_name: String?
    var email: String?
    var external_urls: [String: String]
    var followers: Follower
    var href: String
    var id: String
    var images: [ImageObject]
    var product: String?
    var uri: String
    var type: String
}

struct ImageObject: Codable{
    var height: Int?
    var url: String
    var Width: Int?
}

struct Follower: Codable {
    var href: String?
    var total: Int
}
