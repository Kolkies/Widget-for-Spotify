//
//  SimplifiedShow.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct SimplifiedShow: Codable {
    /// A list of the countries in which the show can be played, identified by their ISO 3166-1 alpha-2 code.
    var available_markets: [String]
    
    /// The copyright statements of the show.
    var copyrights: [Copyright]
    
    /// A description of the show.
    var description: [String]
    
    /// Whether or not the show has explicit content (true = yes it does; false = no it does not OR unknown).
    var explicit: Bool
    
    /// Known external URLs for this show.
    var external_urls: [String: String]
    
    /// A link to the Web API endpoint providing full details of the show.
    var href: String
    
    /// The Spotify ID for the show.
    var id: String
    
    /// The cover art for the show in various sizes, widest first.
    var images: [ImageObject]
    
    /// True if all of the show’s episodes are hosted outside of Spotify’s CDN. This field might be null in some cases.
    var is_externally_hosted: Bool?
    
    /// A list of the languages used in the show, identified by their ISO 639 code.
    var languages: [String]
    
    /// The media type of the show.
    var media_type: String
    
    /// The name of the show.
    var name: String
    
    /// The publisher of the show.
    var publisher: String
    
    /// The object type: “show”.
    var type: String
    
    /// The Spotify URI for the show.
    var uri: String
}
