//
//  SettingsPage.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: AddingAWidget()){
                    HStack{
                        Image(systemName: "text.book.closed")
                        Text("Adding the widget")
                    }
                }
                NavigationLink(destination: AboutPage()){
                    HStack{
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                }
            }
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
