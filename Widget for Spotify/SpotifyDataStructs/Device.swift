//
//  Device.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct Device {
    var id: String?
    var is_active: Bool
    var is_private_session: Bool
    var is_restricted: Bool
    var name: String
    var type: String
    var volume_percent: Int?
}

enum DeviceTypes{
    case Computer, tablet, Smartphone, Speaker, TV, AVR, STB, AudioDongle, GameConsole, CastVideo, CastAudio, Automobile, Unknown
}
