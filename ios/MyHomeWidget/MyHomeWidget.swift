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
    let isFavorite: Bool
    let language: String
    
    static let placeholder = WordOfTheDay(
        word: "Éthéré",
        type: "Adj",
        definition: "D'une beauté irréelle, presque céleste",
        example: "Son regard était d'une beauté éthérée, comme s'il appartenait à un rêve.",
        isFavorite: false,
        language: "fr"
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
        let currentDate = Date()
        
        let wordOfTheDay = getWordOfTheDay() ?? WordOfTheDay.placeholder
        let entry = SimpleEntry(date: currentDate, configuration: configuration, wordOfTheDay: wordOfTheDay)
        
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        
        return Timeline(entries: [entry], policy: .after(nextUpdate))
    }
    
    private func getWordOfTheDay() -> WordOfTheDay? {
        let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
        
        if let allKeys = sharedDefaults?.dictionaryRepresentation().keys {
            print("MyHomeWidget: Available UserDefaults keys: \(Array(allKeys))")
        }
        
        let widgetLanguage = getWidgetLanguage()
        print("MyHomeWidget: Widget language preference: \(widgetLanguage)")
        
        if let jsonString = sharedDefaults?.string(forKey: "word_of_the_day") {
            print("MyHomeWidget: Found word_of_the_day key with value: \(jsonString)")
            if let data = jsonString.data(using: .utf8) {
                do {
                    let decoder = JSONDecoder()
                    let wordOfTheDay = try decoder.decode(WordOfTheDay.self, from: data)
                    print("MyHomeWidget: Successfully decoded word of the day: \(wordOfTheDay.word) (language: \(wordOfTheDay.language))")
                    
                    if wordOfTheDay.language != widgetLanguage {
                        print("MyHomeWidget: Word language (\(wordOfTheDay.language)) doesn't match widget language (\(widgetLanguage))")
                    }
                    
                    return wordOfTheDay
                } catch {
                    print("MyHomeWidget: Error decoding word of the day: \(error)")
                    print("MyHomeWidget: JSON string was: \(jsonString)")
                }
            }
        } else {
            print("MyHomeWidget: No word_of_the_day key found")
        }
        
        print("MyHomeWidget: No word_of_the_day found in UserDefaults, using placeholder")
        return nil
    }
    
    private func getWidgetLanguage() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
        if let languageIndex = sharedDefaults?.integer(forKey: "language_preference") {
            return languageIndex == 0 ? "fr" : "en"
        }
        return "fr" 
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
    
    private var widgetLanguage: String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
        if let languageIndex = sharedDefaults?.integer(forKey: "language_preference") {
            return languageIndex == 0 ? "fr" : "en"
        }
        return "fr" 
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
        if widgetLanguage == "en" {
            switch type.lowercased() {
            case "adjective": return "adj"
            case "noun": return "noun"
            case "verb": return "v"
            case "adverb": return "adv"
            case "pronoun": return "pron"
            case "conjunction": return "conj"
            case "preposition": return "prep"
            case "interjection": return "interj"
            default: return type
            }
        } else {
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
        .description({ 
            let sharedDefaults = UserDefaults(suiteName: "group.com.eloquence.widget")
            if let languageIndex = sharedDefaults?.integer(forKey: "language_preference"), languageIndex == 1 {
                return "Shows the word of the day from Eloquence app."
            } else {
                return "Affiche le mot du jour de l'application Eloquence."
            }
        }())
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
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
