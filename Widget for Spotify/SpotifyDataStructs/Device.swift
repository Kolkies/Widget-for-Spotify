//
//  Device.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct Device: Codable {
    /// The device ID. This may be null.
    var id: String?
    
    /// If this device is the currently active device.
    var is_active: Bool

    /// If this device is currently in a private session.
    var is_private_session: Bool

    /// Whether controlling this device is restricted. At present if this is “true” then no Web API commands will be accepted by this device.
    var is_restricted: Bool

    /// The name of the device.
    var name: String
    
    /// Device type, such as “Computer”, “Smartphone” or “Speaker”.
    var type: String
    
    /// The current volume in percent. This may be null.
    var volume_percent: Int?
}
