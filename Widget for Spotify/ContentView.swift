//
//  ContentView.swift
//  Widget for Spotify
//
//  Created by Sjoerd Bolten on 23/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI
import AppAuth

struct ContentView: View {
    // property of the containing class
    @ObservedObject var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var body: some View {
        VStack{
            Button(action: {
                appDelegate.signin()
                print("login")
            }){
                Text("Login")
            }
            Button(action: {
                appDelegate.connect()
            }){
                Text("Connect")
            }
            Text("")
            Text("Currently playing:")
            Text(appDelegate.currentPlayingSong?.name ?? "No Song Playing")
            Text("By")
            Text(appDelegate.currentPlayingSong?.artist.name ?? "Not available")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
