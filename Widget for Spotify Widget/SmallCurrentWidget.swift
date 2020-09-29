//
//  SmallCurrentWidget.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 29/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct SmallCurrentWidget: View {
    var data: Model
    var useCustomBackground: Bool?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                if(data.widgetData.item != nil && data.albumImage != nil){
                    Image(uiImage: (data.albumImage?.imageWithoutBaseline())!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2)
                } else {
                    Image(data.widgetData.device.name == "Nothing Playing" ? "SpotifyIconGreen" : "PreviewArtAsset")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                    shadow(color: .black, radius: data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2,
                           x: data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2,
                           y: data.widgetData.device.name == "Nothing Playing" || useCustomBackground == true ? 0 : 2)
                }
                
                Text(data.widgetData.item?.name ?? "No Song Playing")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 3.0)
                Text(data.widgetData.device.name)
                    .font(.footnote)
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, 15.0)
//            .padding(.bottom, 10.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            Spacer()
        }
    }
}
