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
import WidgetKit

/// Handles all data retrieved from spotify.
/// Is a singleton. In order to acces use SpotifyData.shared, DO NOT create a new instance
class SpotifyData: ObservableObject {
    static var shared = SpotifyData()
    
    @Published var personInfo: PersonInfo?
    @Published var currentlyPlayingContext: CurrentlyPlayingContext?
    
    private init(){
        print("Fetching data")
        // All methods that should run on launch and can be called from another place to update
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAllLiveData), userInfo: nil, repeats: true)
        
        // All methods that should run on startup since we need to get their info
        getPersonInfo()
    }
    
    @objc func updateAllLiveData() -> Void{
        getCurrentlyPlayingContext()
    }
    
    /// Sets the personInfo property
    func getPersonInfo() -> Void {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SpotifyTokenHandler.accessToken() ?? "")"
        ]
        
        WidgetCenter.shared.reloadAllTimelines()
        
        AF.request("https://api.spotify.com/v1/me", headers: headers).response { response in
            if response.data != nil {
                if let user = try? JSONDecoder().decode(PersonInfo.self, from: response.data!){
                    self.personInfo = user
                    print("Stored Person Data")
                }
            }
        }
    }
    
    /// Sets the personInfo property
    func getCurrentlyPlayingContext() -> Void {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SpotifyTokenHandler.accessToken() ?? "")"
        ]
        
//        WidgetCenter.shared.reloadAllTimelines()
        
        AF.request("https://api.spotify.com/v1/me/player", headers: headers).response { response in
            if response.data != nil {
                do {
                    let context = try JSONDecoder().decode(CurrentlyPlayingContext.self, from: response.data!)
                    
                    self.currentlyPlayingContext = context
                    
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
    
    
}
