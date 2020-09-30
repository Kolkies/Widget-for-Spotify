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
//                NavigationLink(destination: AddingAWidget()){
//                    HStack{
//                        Image(systemName: "text.book.closed")
//                        Text("Adding the widget")
//                    }
//                }
                NavigationLink(destination: AboutPage().navigationBarTitle("About")){
                    HStack{
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                }
                NavigationLink(destination: UpcomingFeatures().navigationBarTitle("Upcoming features")){
                    HStack{
                        Image(systemName: "star")
                        Text("Upcoming features")
                    }
                }
                NavigationLink(destination: ThirdParty().navigationBarTitle("Open source licences")){
                    HStack{
                        Image(systemName: "book")
                        Text("Open source licences")
                        Spacer()
                    }
                }
                Button(action: {
//                    Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                    UIApplication.shared.open(URL(string: "https://netlob.dev/privacy/widget-for-spotify/privacy/")!, options: [:])
                }){
                    HStack{
                        Image(systemName: "safari")
                        Text("Privacy policy")
                        Spacer()
                    }
                }
                Button(action: {
//                    Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                    UIApplication.shared.open(URL(string: "https://netlob.dev/privacy/widget-for-spotify/terms/")!, options: [:])
                }){
                    HStack{
                        Image(systemName: "safari")
                        Text("Terms & conditions")
                        Spacer()
                    }
                }
            }
            Section {
                Button(action: {
//                    Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                    UIApplication.shared.open(URL(string: "https://apps.apple.com/app/apple-store/id1526912392?pt=121772327&ct=Widget%20for%20Spotify&mt=8")!, options: [:])
                }){
                    Text("Check your (advanced) Spotify stats here!")
                }
//            }
//            Section {
                Button(action: {
//                    Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                    UIApplication.shared.open(URL(string: "mailto:widgetforspotify@netlob.dev")!, options: [:])
                }){
                    HStack{
                        Image(systemName: "envelope")
                        Text("Mail us if you've any feedback :)")
                        Spacer()
                    }
                }
            }
            Section {
                Button(action: {
                    showLogOutConfirm = true
                }){
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showLogOutConfirm){
                    Alert(title: Text("Are you sure?"), message: Text("Are you sure you want to log out? This means that you have to log in again in order to use this app"), primaryButton: .destructive(Text("Log Out"), action: {
                        SpotifyTokenHandler.logOut()
                    }), secondaryButton: .cancel())
                }
            }
            
            Banner2()
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
