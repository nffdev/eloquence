//
//  MyHomeWidgetLiveActivity.swift
//  MyHomeWidget
//
//  Created by Night Frost on 28/05/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MyHomeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyHomeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyHomeWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MyHomeWidgetAttributes {
    fileprivate static var preview: MyHomeWidgetAttributes {
        MyHomeWidgetAttributes(name: "World")
    }
}

extension MyHomeWidgetAttributes.ContentState {
    fileprivate static var smiley: MyHomeWidgetAttributes.ContentState {
        MyHomeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyHomeWidgetAttributes.ContentState {
         MyHomeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MyHomeWidgetAttributes.preview) {
   MyHomeWidgetLiveActivity()
} contentStates: {
    MyHomeWidgetAttributes.ContentState.smiley
    MyHomeWidgetAttributes.ContentState.starEyes
}
