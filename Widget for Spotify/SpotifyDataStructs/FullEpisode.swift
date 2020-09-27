//
//  FullEpisode.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct FullEpisode: Codable {
    /// A URL to a 30 second preview (MP3 format) of the episode. null if not available.
    var audio_preview_url: String?
    
    /// A description of the episode.
    var description: String
    
    /// The episode length in milliseconds.
    var duration_ms: Int
    
    /// Whether or not the episode has explicit content (true = yes it does; false = no it does not OR unknown).
    var explicit: Bool
    
    /// External URLs for this episode.
    var external_urls: [String: String]
    
    /// A link to the Web API endpoint providing full details of the episode.
    var href: String

    /// The Spotify ID for the episode.
    var id: String

    /// The cover art for the episode in various sizes, widest first.
    var images: [ImageObject]
    
    /// True if the episode is hosted outside of Spotify’s CDN.
    var is_externally_hosted: Bool
    
    /// True if the episode is playable in the given market. Otherwise false.
    var is_playable: Bool
    
    /// A list of the languages used in the episode, identified by their ISO 639 code.
    var languages: [String]

    /// The name of the episode.
    var name: String
    
    /// The date the episode was first released, for example "1981-12-15". Depending on the precision, it might be shown as "1981" or "1981-12".
    var release_date: String
    
    /// The precision with which release_date value is known: "year", "month", or "day".
    var release_date_precision: String
    
    /// The user’s most recent position in the episode. Set if the supplied access token is a user token and has the scope user-read-playback-position.
    var resume_point: ResumePoint?
    
    /// The show on which the episode belongs.
    var show: SimplifiedShow

    /// The object type: "episode".
    var type: String

    /// The Spotify URI for the episode.
    var uri: String
}
