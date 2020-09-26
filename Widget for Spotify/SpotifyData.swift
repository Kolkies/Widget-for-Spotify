//
//  SpotifyData.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

class SpotifyData: ObservableObject {
    static var shared = SpotifyData()
    var accessToken: String? = SpotifyTokenHandler.accessToken()
    
    private init(){
        
    }
}
