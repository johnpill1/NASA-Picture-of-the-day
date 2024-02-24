//
//  swiftUIApp.swift
//  swiftUI
//
//  Created by John Pill on 12/12/2022.
//

import SwiftUI

@main
struct swiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(result: APODImage(date: "Today's date", explanation: "Explanation", hdurl: "HD URL", media_type: "Media Type", service_version: "Version", title: "Title", url: "URL"))
        }
    }
}
