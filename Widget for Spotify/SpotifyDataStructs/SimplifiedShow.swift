//
//  SimplifiedShow.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct SimplifiedShow {
    var available_markets: [String]
    var copyrights: [Copyright]
    var description: [String]
    var explicit: Bool
    var external_urls: [String: String]
    var href: String
    var id: String
    var images: [ImageObject]
    var is_externally_hosted: Bool?
    var languages: [String]
    var media_type: String
    var name: String
    var publisher: String
    var type: String
    var uri: String
}
