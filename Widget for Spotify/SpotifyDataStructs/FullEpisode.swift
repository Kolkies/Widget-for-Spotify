//
//  FullEpisode.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct FullEpisode {
    var audio_preview_url: String?
    var description: String
    var duration_ms: Int
    var explicit: Bool
    var external_urls: [String: String]
    var href: String
    var id: String
    var images: [ImageObject]
    var is_externally_hosted: Bool
    var is_playable: Bool
    var languages: [String]
    var name: String
    var release_date: String
    var release_date_precision: String
    var resume_point: ResumePoint?
    var show: SimplifiedShow
    var type: String
    var uri: String
}
