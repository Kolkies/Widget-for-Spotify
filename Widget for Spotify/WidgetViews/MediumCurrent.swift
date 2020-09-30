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
                    KFImage(URL(string: (data.widgetData.item?.album.images[0].url)!)!).resizable()
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
                    Image("SpotifyIconGreen")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                        .padding(.horizontal, 2)
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
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
//                                Text("Now Playing: ")
//                                    .font(.subheadline)
//                                    .fontWeight(.bold)
//                                    .multilineTextAlignment(.leading)
                    Text(data.widgetData.item?.name ?? "Nothing playing right now")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 2.0)
                    Text(data.artistName ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
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

struct MediumCurrent_Previews: PreviewProvider {
    static var previews: some View {
        MediumCurrent(data: getExampleModel(context: nil))
    }
}
