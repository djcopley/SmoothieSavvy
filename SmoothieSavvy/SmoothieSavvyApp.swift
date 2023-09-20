//
//  SmoothieSavvyApp.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct SmoothieSavvyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(PreviewSampleData.container)
    }
}
