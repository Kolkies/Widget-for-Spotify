//
//  PersonInfo.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// Struct containing all private user data
/// For more info: https://developer.spotify.com/documentation/web-api/reference/object-model/#user-object-private
struct PersonInfo: Codable {
    var country: String?
    var display_name: String?
    var email: String?
    var external_urls: [String: String]
    var followers: Followers
    var href: String
    var id: String
    var images: [ImageObject]
    var product: String?
    var uri: String
    var type: String
}
