//
//  Album.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// https://developer.spotify.com/documentation/web-api/reference/object-model/#album-object-simplified
struct SimplifiedAlbum: Codable {
    /// The field is present when getting an artist’s albums. Possible values are “album”, “single”, “compilation”, “appears_on”. Compare to album_type this field represents relationship between the artist and the album.
    var album_group: String?
    
    /// The type of the album: one of “album”, “single”, or “compilation”.
    var album_type: String
    
    /// The artists of the album. Each artist object includes a link in href to more detailed information about the artist.
    var artists: [SimplifiedArtist]
    
    /// The markets in which the album is available: ISO 3166-1 alpha-2 country codes. Note that an album is considered available in a market when at least 1 of its tracks is available in that market.
    var available_markets: [String]
    
    /// Known external URLs for this album.
    var external_urls: [String: String]
    
    /// A link to the Web API endpoint providing full details of the album.
    var href: String

    /// The Spotify ID for the album.
    var id: String

    /// The cover art for the album in various sizes, widest first.
    var images: [ImageObject]
    
    /// The name of the album. In case of an album takedown, the value may be an empty string.
    var name: String
    
    /// The date the album was first released, for example 1981. Depending on the precision, it might be shown as 1981-12 or 1981-12-15.
    var release_date: String
    
    /// The precision with which release_date value is known: year , month , or day.
    var release_date_precision: String
    
    /// Part of the response when Track Relinking is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
    var restrictions: String?
    
    /// The object type: “album”
    var type: String

    /// The Spotify URI for the album.
    var uri: String
}
