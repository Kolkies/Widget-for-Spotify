//
//  URL.extension.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 25/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
