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
    var href: String?
    var total: Int
}
