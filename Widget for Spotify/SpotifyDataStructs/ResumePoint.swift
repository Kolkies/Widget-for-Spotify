//
//  ResumePoint.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

struct ResumePoint: Codable {
    var fully_played: Bool
    var resume_position_ms: Int
}
