//
//  WheatherApp.swift
//  WheatherApp
//
//  Created by Александр Ляхов on 15.09.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), Temp: 0, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), Temp: 0, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, Temp: 0, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let Temp: Int
    let configuration: ConfigurationIntent
}
struct CurTemp{
   static var curTemp: Int!
}
let defaults = UserDefaults.standard
var myFlag = defaults.integer(forKey: "myFlag")

struct WheatherAppEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("\(entry.Temp )")
        
    }
}

@main
struct WheatherApp: Widget {
    let kind: String = "WheatherApp"

    var body: some WidgetConfiguration {
        
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()) { entry in
            WheatherAppEntryView(entry: entry)
                .background(Color(.systemGroupedBackground))
        }.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WheatherApp_Previews: PreviewProvider {
    static var previews: some View {
        WheatherAppEntryView(entry: SimpleEntry(date: Date(), Temp: 0, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
