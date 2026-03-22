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
            EditItemView(item: <#Item#>)
        }
        .modelContainer(for: [LinkedinPost.self])
    }
}
