//
//  SpotifyContext.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct SpotifyContext: Codable {
    /// The uri of the context.
    var uri: String
    
    /// The href of the context, or null if not available.
    var href: String?
    
    /// The external_urls of the context, or null if not available.
    var external_urls: [String: String]?
    
    /// The object type of the item’s context. Can be one of album , artist or playlist.
    var type: String
}
