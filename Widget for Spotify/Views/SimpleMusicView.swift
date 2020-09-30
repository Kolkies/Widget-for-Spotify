//
//  SimpleMusicView.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 27/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI
import URLImage

struct SimpleMusicView: View {
    @ObservedObject var spotifyData = SpotifyData.shared
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                if(spotifyData.currentlyPlayingContext?.item != nil){
                    URLImage(URL(string: (spotifyData.currentlyPlayingContext?.item?.album.images[0].url)!)!, placeholder: Image("PreviewArtAsset")){ proxy in
                        proxy.image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                    }
                } else {
                    Image("PreviewArtAsset")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 2, x: 2, y: 2)
                }
                
                Text(spotifyData.currentlyPlayingContext?.item?.name ?? "Nothing playing right now")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 3.0)
                Text(spotifyData.currentlyPlayingContext?.device.name ?? "No device Found")
                    .font(.footnote)
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, 15.0)
//            .padding(.bottom, 10.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            Spacer()
        }
        .background(spotifyData.currentlyPlayingContext?.item != nil ? Color("BackgroundColor") : Color("BackgroundColor"))
    }
}

struct SimpleMusicView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleMusicView()
    }
}
