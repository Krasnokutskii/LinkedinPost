//
//  LinkedinArticlesApp.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 16. 3. 2026..
//

import SwiftUI
import SwiftData

@main
struct LinkedinArticlesApp: App {
    var body: some Scene {
        WindowGroup {
            IndexMacroView()
        }
        .modelContainer(for: [LinkedinPost.self])
    }
}
