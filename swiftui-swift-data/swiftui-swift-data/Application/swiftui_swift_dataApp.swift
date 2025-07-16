//
//  swiftui_swift_dataApp.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//

import SwiftUI

@main
struct swiftui_swift_dataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Project.self, Task.self])
    }
}
