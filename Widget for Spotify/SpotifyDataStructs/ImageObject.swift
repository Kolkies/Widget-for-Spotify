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
    /// The image height in pixels. If unknown: null or not returned.
    var height: Int?
    
    /// The source URL of the image.
    var url: String
    
    /// The image width in pixels. If unknown: null or not returned.
    var Width: Int?
}
