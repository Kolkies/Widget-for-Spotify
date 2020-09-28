//
//  Widget_for_Spotify_Widget.swift
//  Widget for Spotify Widget
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher
import struct KingfisherSwiftUI.KFImage
import Combine

// Creating model for JSON data...

struct Model : TimelineEntry {
    var date: Date
    var widgetData: CurrentlyPlayingContext
    let configuration: ConfigurationIntent
    let albumImage: Kingfisher.KFCrossPlatformImage?
    let playlistName: String?
}

struct Provider: IntentTimelineProvider {
    public typealias Entry = Model
    
    public typealias Intent = ConfigurationIntent
    
    public func placeholder(in context: Context) -> Model {
        return Model(date: Date(), widgetData: CurrentlyPlayingContext(device: Device(is_active: true, is_private_session: false, is_restricted: false, name: "Example Device", type: "Widget"), repeat_state: "IDK", shuffle_state: false, timestamp: 324, is_playing: true, currently_playing_type: "Song", actions: nil), configuration: ConfigurationIntent(), albumImage: nil, playlistName: nil)
    }
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Model) -> Void) {
        let loadingData = Model(date: Date(), widgetData: CurrentlyPlayingContext(device: Device(is_active: true, is_private_session: false, is_restricted: false, name: "Example Device", type: "Widget"), repeat_state: "IDK", shuffle_state: false, timestamp: 324, is_playing: true, currently_playing_type: "Song", actions: nil), configuration: ConfigurationIntent(), albumImage: nil, playlistName: nil)
        completion(loadingData)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Model>) -> Void) {
        // Parsing json data and displaying...
        print("Updating Timeline")
        
        StatusService.getStatus(client: NetworkClient()){ updates in
            debugPrint(updates!)
            if((updates?.is_playing) == true){
                KingfisherManager.shared.retrieveImage(with: URL(string: (updates?.item?.album.images[0].url)!)!){ result in
                    debugPrint(result)
                    switch result{
                    case .success(let value):
                        debugPrint(value)
                        
                        let nextUpdate = Calendar.current.date(byAdding: .second, value: Int(truncating: configuration.refreshTime ?? 30), to: Date())

                        let data = Model(date: nextUpdate!, widgetData: updates!, configuration: ConfigurationIntent(), albumImage: value.image, playlistName: nil)

                        let tomorrow = Calendar.current.date(byAdding: .second, value: 20, to: Date())!
                        let timeline = Timeline(entries: [data], policy: .after(tomorrow))

                        completion(timeline)
                    case .failure(let error):
                        print(error)
                    }
                    
                    
                }
            } else {
                
                let nextUpdate = Calendar.current.date(byAdding: .second, value: Int(truncating: (configuration.refreshTime ?? 30)), to: Date())

                let data = Model(date: nextUpdate!, widgetData: updates!, configuration: ConfigurationIntent(), albumImage: nil, playlistName: nil)

                let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))

                completion(timeline)
            }
            
        }
    }
}

struct CurrentPlayingWidgetEntryView : SwiftUI.View {
    @Environment(\.widgetFamily) var family

    var data: Model
    
    var body: some SwiftUI.View{
        HStack {
            switch family{
            case .systemSmall:
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
                                .shadow(color: .black, radius: data.widgetData.device.name == "Nothing Playing" ? 0 : 2, x: data.widgetData.device.name == "Nothing Playing" ? 0 : 2, y: data.widgetData.device.name == "Nothing Playing" ? 0 : 2)
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
            case .systemMedium:
                HStack{
                    VStack{
                        if(data.widgetData.item != nil && data.albumImage != nil){
                            Image(uiImage: (data.albumImage?.imageWithoutBaseline())!)
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
                
            case .systemLarge:
                HStack{
                    
                }
            @unknown default:
                Text("An unknown error occured")
            }
        }
        .background(data.widgetData.item != nil ? Color("BackgroundColor") : Color("BackgroundColor"))
    }
}

struct CurrentPlayingWidget: Widget {
    let kind: String = "Widget_for_Spotify_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CurrentPlayingWidgetEntryView(data: entry)
        }
        .configurationDisplayName("Spotify Widget")
        .description("Widget to show spotify Data")
        .supportedFamilies([.systemSmall, .systemMedium])
        .onBackgroundURLSessionEvents(matching: "CurrentlyPlaying"){ (string, session) in
            debugPrint(string)
            debugPrint(session)
        }
    }
}
