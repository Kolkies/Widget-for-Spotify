//
//  CurrentlyPlayingContext.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// https://developer.spotify.com/documentation/web-api/reference/player/get-information-about-the-users-current-playback/
struct CurrentlyPlayingContext {
    var device: Device
    var repeat_state: String
    var shuffle_state: Bool
    var context: Context?
    var timestamp: Int
    var progress_ms: Int?
    var is_playing: Bool
    var item: FullTrackOrFullEpisode?
    var currently_playing_type: String
    var actions: Any
}

protocol FullTrackOrFullEpisode{}

extension FullTrack: FullTrackOrFullEpisode {}
extension FullEpisode: FullTrackOrFullEpisode {}
