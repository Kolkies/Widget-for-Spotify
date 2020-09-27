//
//  WidgetBundle.swift
//  Widget for Spotify WidgetExtension
//
//  Created by Bram Koene on 27/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation
import WidgetKit
import SwiftUI

@main
struct SpotifyWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CurrentPlayingWidget()
    }
}
