//
//  WidgetSizes.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation
import SwiftUI

public enum WidgetSizes: String, CaseIterable {
    case smallCurrent
    case mediumCurrent
}

func getExampleModel(context: CurrentlyPlayingContext?) -> Model {
    return Model(date: Date(), widgetData: context ?? CurrentlyPlayingContext(device: Device(is_active: true, is_private_session: false, is_restricted: false, name: "Example Device", type: "Widget"), repeat_state: "IDK", shuffle_state: false, timestamp: 324, is_playing: true, currently_playing_type: "Song", actions: nil), configuration: ConfigurationIntent(), albumImage: nil, playlistName: nil, artistName: nil)
}
