//
//  AuthHandler.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 24/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import Foundation
import AppAuth

let authorizationEndpoint = URL(string: "https://accounts.google.com/o/oauth2/v2/auth")!
let tokenEndpoint = URL(string: "https://www.googleapis.com/oauth2/v4/token")!
let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint,
                                            tokenEndpoint: tokenEndpoint)

struct AuthHandler {
    func login(){
        // builds authentication request
        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: Secret.clientID,
                                              clientSecret: Secret.clientSecret,
                                              scopes: [OIDScopeOpenID, OIDScopeProfile],
                                              redirectURL: URL(string: Secret.redirectURI)!,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)

        // performs authentication request
        print("Initiating authorization request with scope: \(request.scope ?? "nil")")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.currentAuthorizationFlow =
            OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in
          if let authState = authState {
            self.setAuthState(authState)
            print("Got authorization tokens. Access token: " +
                  "\(authState.lastTokenResponse?.accessToken ?? "nil")")
          } else {
            print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
            self.setAuthState(nil)
          }
        }
    }
}
