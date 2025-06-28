//
//  WordListApp.swift
//  WordList
//
//  Created by 杉井位次 on 2025/06/29.
//

import SwiftUI

@main
struct WordListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Word.self)
        }
    }
}
