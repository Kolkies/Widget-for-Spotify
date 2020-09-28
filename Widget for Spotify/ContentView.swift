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
                    .foregroundColor(.black)
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

struct SpotifySignIn: View{
    var body: some View{
        HStack {
            Image("SpotifyIconWhite")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding([.top, .bottom], 12.0)
                .padding(.leading, 20.0)
            Text("Log in with Spotify")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding([.top, .bottom], 12)
                .padding(.leading, 4.0)
                .padding(.trailing, 20.0)
            
        }
        .background(Color.green)
        .cornerRadius(17.5)
    }
}
