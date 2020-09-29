//
//  SettingsPage.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct SettingsPage: View {
    @State var  showLogOutConfirm = false
    
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
            Section {
                Button(action: {
                    showLogOutConfirm = true
                }){
                    Text("Sign Out")
                }
                .alert(isPresented: $showLogOutConfirm){
                    Alert(title: Text("Are you sure?"), message: Text("Are you sure you want to log out? This means that you have to log in again in order to use this app"), primaryButton: .destructive(Text("Log Out"), action: {
                        SpotifyTokenHandler.logOut()
                    }), secondaryButton: .cancel())
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
