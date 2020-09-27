//
//  MainView.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI
import WidgetKit

struct MainView: View {
    @ObservedObject var spotifyData = SpotifyData.shared
    
    var body: some View {
        TabView{
            NavigationView{
                VStack(spacing: 6.0){
                    Text("Welkom " + (spotifyData.personInfo?.display_name ?? "Gebruiker"))
                    Button(action: {
                        WidgetCenter.shared.reloadAllTimelines()
                    }){
                        Text("Restart widget")
                    }
                    
                    SimpleMusicView()
                }
                    .navigationBarTitle("Main Page")
            }
            .tabItem {
                Image(systemName: "music.note.list")
                Text("Main")
            }
            
            NavigationView{
                Text("Tutorials")
                    .navigationBarTitle("Tutorials")
            }
            .tabItem {
                Image(systemName: "text.book.closed")
                Text("Tutorials")
            }
            
            NavigationView{
                Text("Settings")
                    .navigationBarTitle("Settings Page")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .onAppear {
            SpotifyData.shared.getPersonInfo()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
