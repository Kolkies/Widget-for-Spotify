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
import URLImage
import Combine

var exampleCurrentlyPlaying = CurrentlyPlayingContext(device: Device(is_active: true, is_private_session: false, is_restricted: false, name: "Example Device", type: "Widget"), repeat_state: "IDK", shuffle_state: false, timestamp: 324, is_playing: true, currently_playing_type: "Song", actions: "None")

// Creating model for JSON data...

struct Model : TimelineEntry {
    var date: Date
    var widgetData: CurrentlyPlayingContext
    let configuration: ConfigurationIntent
}

struct Provider: IntentTimelineProvider {
    public typealias Entry = Model
    
    public typealias Intent = ConfigurationIntent
    
    public func placeholder(in context: Context) -> Model {
        return Model(date: Date(), widgetData: CurrentlyPlayingContext(device: Device(is_active: true, is_private_session: false, is_restricted: false, name: "Example Device", type: "Widget"), repeat_state: "IDK", shuffle_state: false, timestamp: 324, is_playing: true, currently_playing_type: "Song", actions: "None"), configuration: ConfigurationIntent())
    }
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Model) -> Void) {
        let loadingData = Model(date: Date(), widgetData: CurrentlyPlayingContext(device: Device(is_active: true, is_private_session: false, is_restricted: false, name: "Example Device", type: "Widget"), repeat_state: "IDK", shuffle_state: false, timestamp: 324, is_playing: true, currently_playing_type: "Song", actions: "None"), configuration: ConfigurationIntent())
        completion(loadingData)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Model>) -> Void) {
        // Parsing json data and displaying...
        
        DataFetcher.shared.GetCurrentlyPlayingContextWidget {(modelData) in
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())
            
            let data = Model(date: nextUpdate!, widgetData: modelData ?? exampleCurrentlyPlaying, configuration: ConfigurationIntent())
            
            let timeline = Timeline(entries: [data], policy: .atEnd)
            
            completion(timeline)
        }
        
        StatusService.getStatus(client: NetworkClient()){ updates in
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())
            
            let data = Model(date: nextUpdate!, widgetData: updates, configuration: ConfigurationIntent())
            
            let timeline = Timeline(entries: [data], policy: .atEnd)
            
            completion(timeline)
        }
    }
}

struct Widget_for_Spotify_WidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily

    var data: Model
    
    var body: some View{
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                if(data.widgetData.item != nil){
                    URLImage(URL(string: "") ?? URL(string: "")!, placeholder: Image("PreviewArtAsset")){ proxy in
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
        .background(data.widgetData.item != nil ? Color("BackgroundColor") : Color("BackgroundColor"))
    }
}

struct CurrentPlayingWidget: Widget {
    let kind: String = "Widget_for_Spotify_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Widget_for_Spotify_WidgetEntryView(data: entry)
        }
        .configurationDisplayName("Spotify Widget")
        .description("Widget to show spotify Data")
    }
}

public class DataFetcher : ObservableObject{
    
    var cancellable : Set<AnyCancellable> = Set()
    
    static let shared = DataFetcher()
    
    func GetCurrentlyPlayingContextWidget(completion: @escaping (CurrentlyPlayingContext?) -> Void){
        let url = "https://api.spotify.com/v1/me/player"
        
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("Bearer " + (UserDefaults(suiteName: "group.dev.netlob.widget-for-spotify")?.string(forKey: "accessToken") ?? ""), forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: CurrentlyPlayingContext.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
 
        }) { response in
            completion(response)
        }
        .store(in: &cancellable)
    }
}

@main
struct SpotifyWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        //AddYourWidgetHere()
        CurrentPlayingWidget()
    }
}

//func getCurrentlyPlayingContextCompletion(completion: @escaping (CurrentlyPlayingContext?) -> ()){
//    let url = "https://api.spotify.com/v1/me/player"
//
//    let urlSession: URLSession = {
//        let config = URLSessionConfiguration.background(withIdentifier: "CurrentlyPlayingContext")
//        config.isDiscretionary = true
//        config.sessionSendsLaunchEvents = true
//        return URLSession(configuration: config)
//    }()
//    debugPrint(UserDefaults(suiteName: "group.dev.netlob.widget-for-spotify")?.string(forKey: "accessToken"))
//
//    var request = URLRequest(url: URL(string: url)!)
//    request.setValue("Bearer " + (UserDefaults(suiteName: "group.dev.netlob.widget-for-spotify")?.string(forKey: "accessToken") ?? ""), forHTTPHeaderField: "Authorization")
//
//    urlSession.dataTask(with: request) { (data, _, err) in
//        if err != nil {
//            print(err?.localizedDescription)
//        }
//
//        do{
//            let jsonData = try JSONDecoder().decode(CurrentlyPlayingContext.self, from: data!)
//            debugPrint(data)
//
//            completion(jsonData)
//        }
//        catch{
//            debugPrint(error.localizedDescription)
//        }
//    }.resume()
//}
