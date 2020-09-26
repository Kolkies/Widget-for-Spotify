//
//  ImageObject.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// Image object from Spotify
/// For more info: https://developer.spotify.com/documentation/web-api/reference/object-model/#image-object
struct ImageObject: Codable{
    var height: Int?
    var url: String
    var Width: Int?
}
