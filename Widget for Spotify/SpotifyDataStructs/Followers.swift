//
//  Followers.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// Struct that defines a followers model
/// For more info: https://developer.spotify.com/documentation/web-api/reference/object-model/#followers-object
struct Followers: Codable {
    /// A link to the Web API endpoint providing full details of the followers; null if not available. Please note that this will always be set to null, as the Web API does not support it at the moment.
    var href: String?
    
    /// The total number of followers.
    var total: Int
}
