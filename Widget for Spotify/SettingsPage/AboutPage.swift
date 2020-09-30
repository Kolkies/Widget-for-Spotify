//
//  AboutPage.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5){
                VStack(alignment: .leading) {
                    Text("Credits")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 15)
                    HStack(spacing: 0){
                        Text("Development and design: ")
                        Spacer()
                        Link("Bram Koene", destination: URL(string: "https://github.com/minestarnl")!)
                    }
                    HStack(spacing: 0){
                        Text("Design and distribution: ")
                        Spacer()
                        Link("Sjoerd Bolten", destination: URL(string: "https://netlob.dev")!)
                    }
                }
                
                Divider().padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    Text("Feedback")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("If you have any feedback or whatsoever, feel free to contact mail us")
                    Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                }
                
                Divider().padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    Text("Copyright")
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack(spacing: 0){
                        Text("Spotify logo and branding owned by ")
                        Link("Spotify AB", destination: URL(string: "https://spotify.com")!)
                        Spacer()
                    }
                    Text("\nWe claim no rights to any (art) work shown using this app. This is just a medium for users to quickly see what they are listenening. All rights belong to the original authors.")
                    Text("\nThis appand their respective authors fully comply with the Spotify Branding Guidelines and the Spotify Developer Terms of Service, which can be found below:")
                    Link("Spotify Branding Guidelines", destination: URL(string: "https://developer.spotify.com/branding-guidelines/")!)
                    Link("Spotify Developer Terms of Service", destination: URL(string: "https://developer.spotify.com/terms/")!)
                }
                Spacer()
            }.padding(.horizontal, 20)
        }
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
