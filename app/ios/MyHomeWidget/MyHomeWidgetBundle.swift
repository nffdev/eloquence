//
//  MyHomeWidgetBundle.swift
//  MyHomeWidget
//
//  Created by Night Frost on 28/05/2025.
//

import WidgetKit
import SwiftUI

@main
struct MyHomeWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyHomeWidget()
        MyHomeWidgetControl()
        MyHomeWidgetLiveActivity()
    }
}
