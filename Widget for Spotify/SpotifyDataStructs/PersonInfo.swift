//
//  PersonInfo.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation

/// Struct containing all private user data
/// For more info: https://developer.spotify.com/documentation/web-api/reference/object-model/#user-object-private
struct PersonInfo: Codable {
    /// The country of the user, as set in the user’s account profile. An ISO 3166-1 alpha-2 country code. This field is only available when the current user has granted access to the user-read-private scope.
    var country: String?
    
    /// The name displayed on the user’s profile. nil if not available.
    var display_name: String?
    
    /// The user’s email address, as entered by the user when creating their account. Important! This email address is unverified; there is no proof that it actually belongs to the user. This field is only available when the current user has granted access to the user-read-email scope.
    var email: String?
    
    /// Known external URLs for this user.
    var external_urls: [String: String]
    
    /// Information about the followers of the user.
    var followers: Followers
    
    /// A link to the Web API endpoint for this user.
    var href: String
    
    /// The Spotify user ID for the user.
    var id: String
    
    /// The user’s profile image.
    var images: [ImageObject]
    
    /// The user’s Spotify subscription level: “premium”, “free”, etc. (The subscription level “open” can be considered the same as “free”.) This field is only available when the current user has granted access to the user-read-private scope.
    var product: String?
    
    /// The object type: “user”
    var uri: String
    
    /// The Spotify URI for the user.
    var type: String
}
