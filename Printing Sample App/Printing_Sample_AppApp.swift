//
//  Printing_Sample_AppApp.swift
//  Printing Sample App
//
//  Created by Masamichi Ebata on 2024/07/05.
//

import SwiftUI

@main
struct Printing_Sample_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            PrintCommands()
        }
    }
}
