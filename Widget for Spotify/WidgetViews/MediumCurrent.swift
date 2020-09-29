//
//  MediumCurrent.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MediumCurrent: SwiftUI.View {
    var data: Model
    var isInApp: Bool?
    
    var body: some SwiftUI.View {
        HStack{
            VStack{
                if(data.widgetData.item?.album.images[0].url != nil){
                    KFImage(URL(string: (data.widgetData.item?.album.images[0].url)!)!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                } else {
                    Image(data.widgetData.device.name == "Nothing Playing" ? "SpotifyIconGreen" : "PreviewArtAsset")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                        .padding(.horizontal, 2)
                        .shadow(color: .black, radius: data.widgetData.device.name == "Nothing Playing" ? 0 : 2, x: data.widgetData.device.name == "Nothing Playing" ? 0 : 2, y: data.widgetData.device.name == "Nothing Playing" ? 0 : 2)
                }
                
                Spacer()
            }
            
            VStack{
                VStack(alignment: .leading, spacing: 3) {
                    Text("Now Playing: ")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(data.widgetData.item?.name ?? "No Song Playing")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 2.0)
                    Text(data.playlistName ?? data.widgetData.item?.album.name ?? "")
                        .font(.subheadline)
                        .fontWeight(.regular)
                    Text(data.widgetData.device.name)
                        .font(.footnote)
                        .fontWeight(.light)
                }
                Spacer()
                HStack{
                    Image(systemName: "shuffle")
                        .foregroundColor(data.widgetData.shuffle_state ? .green : .gray)
                    if((data.widgetData.item?.explicit) != nil && data.widgetData.item?.explicit == true){
                        Image(systemName: "e.square.fill")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.leading, 5)
                
        }
        .padding(.vertical, 12.0)
        .padding(.horizontal, 15.0)
//            .padding(.bottom, 10.0)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct MediumCurrent_Previews: PreviewProvider {
    static var previews: some View {
        MediumCurrent(data: getExampleModel(context: nil))
    }
}
