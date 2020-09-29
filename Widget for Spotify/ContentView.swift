//
//  ContentView.swift
//  Widget for Spotify
//
//  Created by Sjoerd Bolten on 23/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // property of the containing class
    @ObservedObject var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @ObservedObject var spotifyTokenhandler = SpotifyTokenHandler.shared
    
    var body: some View {
        switch spotifyTokenhandler.authState {
        case AuthState.SIGNEDIN:
            MainView()
        case AuthState.NOTSIGNEDID:
            VStack(spacing: 50) {
                Text("Please login with Spotify to continue")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
//                Text("Please press the button below to sign in and access this app")
//                    .font(.subheadline)
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.black)
                Button(action: {
                    appDelegate.signin()
                    print("login")
                }) {
                    SpotifySignIn()
                }
            }
            .padding(.horizontal, 40.0)
        case AuthState.UNKOWN:
            Text("Fetching user status. Please wait while we talk to the Spotify servers.")
                .onAppear{
                    SpotifyTokenHandler.refreshToken()
                }
        default:
            Text("Unknown")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
