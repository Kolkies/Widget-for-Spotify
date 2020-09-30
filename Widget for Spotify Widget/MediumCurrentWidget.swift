//
//  MediumCurrentWidget.swift
//  Widget for Spotify WidgetExtension
//
//  Created by Bram Koene on 30/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct MediumCurrentWidget: View {
    @State var data: Model
    @State var useCustomBackground: Bool
    
    var body: some View {
        HStack{
            VStack{
                if(data.widgetData.item != nil && data.albumImage != nil){
                    Image(uiImage: (data.albumImage?.imageWithoutBaseline())!)
                            .resizable()
                            .scaledToFit()
//                                    .cornerRadius(useCustomBackground ? 5 : 10)
                        .cornerRadius(10)
                        .shadow(
//                                        color: Color.black.opacity(0.5),
//                                        radius: useCustomBackground ? 0 : 2,
//                                        x: 0,
//                                        y: 0
                            color: Color.black.opacity(0.3),
                            radius: 5,
                            x: 0, //data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2,
                            y: 0 //data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2
                        )
                } else {
                    Image(data.widgetData.device.name == "Nothing Playing" ? "SpotifyIconGreen" : "PreviewArtAsset")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                        .padding(.horizontal, 2)
                        .shadow(
//                                        color: Color.black.opacity(0.5),
//                                        radius: data.widgetData.device.name == "Nothing Playing" || useCustomBackground ? 0 : 2,
//                                        x: 0, //data.widgetData.device.name == "Nothing Playing" || useCustomBackground ? 0 : 2,
//                                        y: 0 //data.widgetData.device.name == "Nothing Playing" || useCustomBackground ? 0 : 2
                            
                            color: Color.black.opacity(0.3),
                            radius: 5,
                            x: 0, //data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2,
                            y: 0 //data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2
                        )
                }
                
//                            Spacer()
            }
            
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    if(data.configuration.showNowPlaying?.boolValue == true){
                        Text("Now Playing: ")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                    }
                    Text(data.widgetData.item?.name ?? "Nothing playing right now")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 2.0)
                    Text(data.artistName ?? "")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                    Text(data.playlistName ?? "")
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                Spacer()
                HStack {
                    if(data.widgetData.shuffle_state == true){
                        Image(systemName: "shuffle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundColor(.green)
                    }
                    if((data.widgetData.item?.explicit) != nil && data.widgetData.item?.explicit == true){
                        Image(systemName: "e.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundColor(.green)
                    }
                }
                Text(data.widgetData.device.name)
                    .font(.footnote)
                    .fontWeight(.light)
            }
            .padding(.leading, 5)
                
        }
        .padding(.vertical, 12.0)
        .padding(.horizontal, 15.0)
//            .padding(.bottom, 10.0)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}
