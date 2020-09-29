//
//  StatusService.swift
//  Widget for Spotify WidgetExtension
//
//  Created by Bram Koene on 27/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

public struct StatusService {
    public static var currentPlayingContextRequest: URLRequest {
        let url = "https://api.spotify.com/v1/me/player"
        
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("Bearer " + (UserDefaults(suiteName: "group.dev.netlob.widget-for-spotify")?.string(forKey: "accessToken") ?? ""), forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    static func getStatus(client: NetworkClient, completion: ((CurrentlyPlayingContext?) -> Void)? = nil) {
        runStatusRequest(currentPlayingContextRequest, on: client, completion: completion)
    }

    private static func runStatusRequest(_ request: URLRequest,
                                         on client: NetworkClient,
                                         completion: ((CurrentlyPlayingContext) -> Void)? = nil) {
        client.executeRequest(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    if (data.count != 0) {
                        let lineStatus = try decoder.decode(CurrentlyPlayingContext.self, from: data)
                        completion?(lineStatus)
                    } else {
                        let nothingPlaying = CurrentlyPlayingContext(device: Device(is_active: false, is_private_session: false, is_restricted: false, name: "Nothing Playing", type: "Nothing Playing"), repeat_state: "none", shuffle_state: false, timestamp: 0, is_playing: false, currently_playing_type: "Nothing")
                        completion?(nothingPlaying)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
