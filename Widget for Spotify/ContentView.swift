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
            Button(action: {
                appDelegate.signin()
                print("login")
            }){
                SpotifySignIn()
            }
        case AuthState.UNKOWN:
            Text("Fetching user status. Please wait while we talk to the Spotify servers.")
                .onAppear{
                    SpotifyTokenHandler.refreshToken()
                }
        default:
            Text("Unknow")
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
            Image("SpotifyLogo")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding([.top, .leading, .bottom], 12.0)
            Text("Log in with Spotify")
                .foregroundColor(.white)
                .padding([.top, .bottom, .trailing], 12)
                .padding(.leading, 4.0)
        }
        .background(Color.green)
        .cornerRadius(8.0)
    }
}
