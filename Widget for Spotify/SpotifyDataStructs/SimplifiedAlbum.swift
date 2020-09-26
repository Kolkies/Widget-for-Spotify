//
//  Album.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// https://developer.spotify.com/documentation/web-api/reference/object-model/#album-object-simplified
struct SimplifiedAlbum {
    var album_group: String?
    var album_type: String
    var artists: [SimplifiedArtist]
    var available_markets: [String]
    var external_urls: [String: String]
    var href: String
    var id: String
    var images: [ImageObject]
    var name: String
    var release_date: String
    var release_date_precision: String
    var restrictions: Any?
    var type: String
    var uri: String
}
