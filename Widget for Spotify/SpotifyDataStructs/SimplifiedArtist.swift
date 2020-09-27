//
//  SimplifiedArtist.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct SimplifiedArtist: Codable {
    /// Known external URLs for this artist.
    var external_urls: [String: String]
    
    /// A link to the Web API endpoint providing full details of the artist.
    var href: String
    
    /// The Spotify ID for the artist.
    var id: String
    
    /// The name of the artist.
    var name: String
    
    /// The object type: "artist"
    var type: String
    
    /// The Spotify URI for the artist.
    var uri: String
}
