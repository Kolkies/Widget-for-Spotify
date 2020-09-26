//
//  FullTrack.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct FullTrack {
    var album: SimplifiedAlbum
    var artists: [SimplifiedArtist]
    var available_markets: [String]
    var disc_number: Int
    var duration_ms: Int
    var explicit: Bool
    var external_ids: [String: Any]
    var external_urls: [String: String]
    var href: String
    var id: String
    var is_playable: Bool
    var linked_from: Any?
    var restrictions: Any?
    var name: String
    var popularity: Int
    var preview_url: String?
    var track_number: Int
    var type: String
    var uri: String
    var is_local: Bool
}
