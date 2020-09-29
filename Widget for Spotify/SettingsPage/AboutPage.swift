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
                        Spacer()
                        Link("Bram Koene", destination: URL(string: "https://github.com/minestarnl")!)
                    }
                    HStack(spacing: 0){
                        Text("Design and distribution: ")
                        Spacer()
                        Link("Sjoerd Bolten", destination: URL(string: "https://netlob.dev")!)
                    }
                    Divider()
                        .padding(.vertical, 20)
                    VStack(alignment: .leading) {
                        Text("If you have any feedback or whatsoever, feel free to contact mail us")
                        Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                    }
                    Divider()
                        .padding(.vertical, 20)
                    HStack(spacing: 0){
                        Text("Spotify logo and branding owned by: ")
                        Link("Spotify AB", destination: URL(string: "https://spotify.com")!)
                        Spacer()
                    }
                    NavigationLink(destination: ThirdParty().navigationBarTitle("Third Party")){
                        HStack{
                            Image(systemName: "info.circle")
                            Text("Third party Software")
                            Spacer()
                        }
                    }
                    Divider()
                        .padding(.vertical, 20)
                    Text("We claim no rights to any work shown using this app. This is just a medium for users to quickly see what they are listenening. All rights belong to the original authors.")
                        .padding(.horizontal, 0)
                }
                .multilineTextAlignment(.leading)
                Spacer()
            }.padding(.leading, 5)
        }
        .padding(.horizontal, 15)
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
