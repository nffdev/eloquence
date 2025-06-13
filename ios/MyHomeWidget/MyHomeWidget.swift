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
        let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
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
    
    private var isDarkMode: Bool {
        let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
        return sharedDefaults?.bool(forKey: "theme_preference") ?? true
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 8) {
                    Spacer()
                    
                    Text(entry.wordOfTheDay.word)
                        .font(.custom("PlayfairDisplay-Bold", size: widgetFamily == .systemSmall ? 24 : 28))
                        .foregroundColor(primaryTextColor)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                    
                    Text(getShortType(entry.wordOfTheDay.type))
                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                        .foregroundColor(secondaryTextColor)
                        .lineLimit(1)
                    
                    if widgetFamily != .systemSmall {
                        Spacer().frame(height: 10)
                    }
                    
                    Text(entry.wordOfTheDay.definition)
                        .font(.custom("Lato-Regular", size: widgetFamily == .systemSmall ? 12 : 16))
                        .foregroundColor(bodyTextColor)
                        .lineLimit(widgetFamily == .systemSmall ? 3 : 5)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                }
                .padding(widgetFamily == .systemSmall ? 8 : 12)
            }
        }
    }
    
    private var backgroundColor: Color {
        isDarkMode ? Color.black : Color.white
    }
    
    private var primaryTextColor: Color {
        isDarkMode ? Color.white : Color.black
    }
    
    private var secondaryTextColor: Color {
        isDarkMode ? Color.white.opacity(0.7) : Color.black.opacity(0.87)
    }
    
    private var bodyTextColor: Color {
        isDarkMode ? Color.white.opacity(0.6) : Color.black.opacity(0.54)
    }
    
    private func getShortType(_ type: String) -> String {
        switch type.lowercased() {
        case "adjectif": return "adj"
        case "nom", "nom commun", "nom propre": return "nom"
        case "verbe": return "v"
        case "adverbe": return "adv"
        case "pronom": return "pron"
        case "conjonction": return "conj"
        case "préposition": return "prép"
        case "interjection": return "interj"
        default: return type
        }
    }
}

struct MyHomeWidget: Widget {
    let kind: String = "MyHomeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MyHomeWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
                    let isDarkMode = sharedDefaults?.bool(forKey: "theme_preference") ?? true
                    ContainerRelativeShape()
                        .fill(isDarkMode ? Color.black : Color.white)
                }
        }
        .configurationDisplayName("Eloquence Widget")
        .description("Affiche le mot du jour de l'application Eloquence.")
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
