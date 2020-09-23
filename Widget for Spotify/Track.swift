//
//  Track.swift
//  Widget for Spotify
//
//  Created by Sjoerd Bolten on 23/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct Track: Identifiable, Codable {
    let name: String
    let artist: String
    let image: String // image url
    
    var id: String { name }
}
