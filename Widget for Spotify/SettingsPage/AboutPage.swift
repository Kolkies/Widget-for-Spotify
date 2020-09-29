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
        HStack(alignment: .top, spacing: 5){
            VStack(alignment: .leading, spacing: 5) {
                Text("Credits")
                    .font(.title3)
                    .padding(.top, 15)
                VStack(spacing: 5){
                    HStack(spacing: 0){
                        Text("Development and design: ")
                        Link("Bram Koene", destination: URL(string: "https://github.com/minestarnl")!)
                        Spacer()
                    }
                    HStack(spacing: 0){
                        Text("Design and distribution: ")
                        Link("Sjoerd Bolten", destination: URL(string: "https://netlob.dev")!)
                        Spacer()
                    }
                    Divider()
                        .padding(.vertical, 20)
                    Text("Know a way we can improve this app?")
                        .multilineTextAlignment(.leading)
                    Text("Feel free to contact us")
                        .multilineTextAlignment(.leading)
                    HStack{
                        Link("Discord server", destination: URL(string: "https://discord.gg/uZ7whYj")!)
                        Text("Ping @brem or @sjoerdini")
                        Spacer()
                    }
                    Divider()
                        .padding(.vertical, 20)
                    HStack(spacing: 0){
                        Text("Spotify logo and branding owned by: ")
                        Link("Spotify AB", destination: URL(string: "https://spotify.com")!)
                        Spacer()
                    }
                    Divider()
                        .padding(.vertical, 20)
                    Text("We claim no rights to any work shown using this app. This is just a medium for users to quickly see what they are listenening. All rights belong to the original authors.")
                        .padding(.horizontal, 0)
                }
                .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .padding(.horizontal, 10)
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
