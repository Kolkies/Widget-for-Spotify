//
//  FullTrack.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct FullTrack: Codable {
    /// The album on which the track appears. The album object includes a link in href to full information about the album.
    var album: SimplifiedAlbum
    
    /// The artists who performed the track. Each artist object includes a link in href to more detailed information about the artist.
    var artists: [SimplifiedArtist]
    
    /// A list of the countries in which the track can be played, identified by their ISO 3166-1 alpha-2 code.
    var available_markets: [String]
    
    /// The disc number (usually 1 unless the album consists of more than one disc).
    var disc_number: Int
    
    /// The track length in milliseconds.
    var duration_ms: Int
    
    /// Whether or not the track has explicit lyrics ( true = yes it does; false = no it does not OR unknown).
    var explicit: Bool

    /// Known external IDs for the track.
    var external_ids: [String: String]
    
    /// Known external URLs for this track.
    var external_urls: [String: String]
    
    /// A link to the Web API endpoint providing full details of the track.
    var href: String
    
    /// The Spotify ID for the track.
    var id: String
    
    /// Part of the response when Track Relinking is applied. If true , the track is playable in the given market. Otherwise false.
    var is_playable: Bool?
    
    /// Part of the response when Track Relinking is applied, and the requested track has been replaced with different track. The track in the linked_from object contains information about the originally requested track.
    var linked_from: String?
    
    /// Part of the response when Track Relinking is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
    var restrictions: String?
    
    /// The name of the track.
    var name: String
    
    /// The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.
    /// The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.
    /// Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past. Duplicate tracks (e.g. the same track from a single and an album) are rated independently. Artist and album popularity is derived mathematically from track popularity. Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.
    var popularity: Int
    
    /// A link to a 30 second preview (MP3 format) of the track. Can be null
    var preview_url: String?
    
    /// The number of the track. If an album has several discs, the track number is the number on the specified disc.
    var track_number: Int
    
    /// The object type: “track”.
    var type: String
    
    /// The Spotify URI for the track.
    var uri: String
    
    /// Whether or not the track is from a local file.
    var is_local: Bool
}
