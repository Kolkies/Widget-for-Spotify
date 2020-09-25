//
//  Widget_for_Spotify_Widget.swift
//  Widget for Spotify Widget
//
//  Created by Bram Koene on 23/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Widget_for_Spotify_WidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                Image("PreviewArtAsset")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                Text("Nummer Titel")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 3.0)
                Text("Spotify")
                    .font(.subheadline)
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, 15.0)
//            .padding(.bottom, 10.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            Spacer()
        }
        .background(Color("BackgroundColor"))
    }
    
}

@main
struct Widget_for_Spotify_Widget: Widget {
    let kind: String = "Widget_for_Spotify_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Widget_for_Spotify_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct Widget_for_Spotify_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Widget_for_Spotify_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
