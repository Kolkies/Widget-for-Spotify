//
//  CurrentlyPlayingContext.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// https://developer.spotify.com/documentation/web-api/reference/player/get-information-about-the-users-current-playback/
public struct CurrentlyPlayingContext: Codable {
    /// The device that is currently active
    var device: Device
    
    /// off, track, context
    var repeat_state: String
    
    /// If shuffle is on or off
    var shuffle_state: Bool
    
    /// A Context Object. Can be null (e.g. If private session is enabled this will be null).
    var context: SpotifyContext?
    
    /// Unix Millisecond Timestamp when data was fetched
    var timestamp: Int
    
    /// Progress into the currently playing track. Can be null (e.g. If private session is enabled this will be null).
    var progress_ms: Int?
    
    /// If something is currently playing.
    var is_playing: Bool
    
    /// The currently playing track or episode. Can be null (e.g. If private session is enabled this will be null).
    var item: FullTrack?

    /// The object type of the currently playing item. Can be one of track, episode, ad or unknown.
    var currently_playing_type: String
    
    /// Allows to update the user interface based on which playback actions are available within the current context
    var actions: String
}

//protocol FullTrackOrFullEpisode: Codable{}
//
//extension FullTrack: FullTrackOrFullEpisode {}
//extension FullEpisode: FullTrackOrFullEpisode {}
