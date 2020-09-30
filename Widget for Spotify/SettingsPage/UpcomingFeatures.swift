//
//  AboutPage.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct UpcomingFeatures: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text("These are some of the features you can expect in a future update :)")
                    .font(.title2)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Customizable widget")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("This feature will allow users to change the background color and foreground (text etc) color of the widget. Optionally the user can use an image as background.\n\nThis will also mean that the 'Nothing playing right now' widget can be customized to the users' preference")
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Pick a song")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("This feature will allow users to pick a specifick song which will be staticly displayed in a widget (for example their favorite song). The currently playing widget will still be available to the user.")
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Real time updates")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Self-explanatory :) Despite being very difficult, we are doing our best to implement this feature!")
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("More suggestions?")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Feel free to contact us :)")
                    
                    Link("widgetforspotify@netlob.dev", destination: URL(string: "mailto:widgetforspotify@netlob.dev")!)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct UpcomingFeatures_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingFeatures()
    }
}
