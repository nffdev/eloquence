//
//  MyHomeWidget.swift
//  MyHomeWidget
//
//  Created by Night Frost on 28/05/2025.
//

import WidgetKit
import SwiftUI
import Foundation

struct WordOfTheDay: Codable {
    let word: String
    let type: String
    let definition: String
    let example: String
    let date: String
    let isFavorite: Bool
    
    static let placeholder = WordOfTheDay(
        word: "Éthéré",
        type: "Adjectif",
        definition: "Qui a une légèreté, une délicatesse extrême, qui semble immatériel.",
        example: "Une musique éthérée qui transporte l'auditeur dans un autre monde.",
        date: "2025-05-28",
        isFavorite: false
    )
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), wordOfTheDay: WordOfTheDay.placeholder)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let wordOfTheDay = getWordOfTheDay() ?? WordOfTheDay.placeholder
        return SimpleEntry(date: Date(), configuration: configuration, wordOfTheDay: wordOfTheDay)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of entries every 6 hours, starting from the current date.
        let currentDate = Date()
        let wordOfTheDay = getWordOfTheDay() ?? WordOfTheDay.placeholder
        
        for hourOffset in stride(from: 0, to: 24, by: 6) {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, wordOfTheDay: wordOfTheDay)
            entries.append(entry)
        }

        // Update at midnight for new word of the day
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func getWordOfTheDay() -> WordOfTheDay? {
        let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.app")
        guard let data = sharedDefaults?.data(forKey: "word_of_the_day") else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let wordOfTheDay = try decoder.decode(WordOfTheDay.self, from: data)
            return wordOfTheDay
        } catch {
            print("Error decoding word of the day: \(error)")
            return nil
        }
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let wordOfTheDay: WordOfTheDay
}

struct MyHomeWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.97)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.wordOfTheDay.word)
                    .font(widgetFamily == .systemSmall ? .title2 : .title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.6))
                    .lineLimit(1)
                
                Text(entry.wordOfTheDay.type)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                if widgetFamily != .systemSmall {
                    Divider()
                }
                
                Text(entry.wordOfTheDay.definition)
                    .font(widgetFamily == .systemSmall ? .caption : .body)
                    .foregroundColor(.black)
                    .lineLimit(widgetFamily == .systemSmall ? 2 : 4)
                    .fixedSize(horizontal: false, vertical: true)
                
                if widgetFamily == .systemLarge {
                    Text("Exemple:")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    
                    Text(entry.wordOfTheDay.example)
                        .font(.caption)
                        .foregroundColor(.black)
                        .italic()
                        .lineLimit(2)
                }
                
                Spacer()
                
                HStack {
                    Text("Eloquence")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(formatDate(entry.date))
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding(12)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

struct MyHomeWidget: Widget {
    let kind: String = "MyHomeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MyHomeWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    MyHomeWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, wordOfTheDay: WordOfTheDay.placeholder)
}

#Preview(as: .systemMedium) {
    MyHomeWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, wordOfTheDay: WordOfTheDay.placeholder)
}

#Preview(as: .systemLarge) {
    MyHomeWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, wordOfTheDay: WordOfTheDay.placeholder)
}
