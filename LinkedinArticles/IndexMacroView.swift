//
//  IndexMacroView.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 19. 3. 2026..
//

import SwiftUI
import SwiftData

@Model
final class LinkedinPost {
    var id: UUID
    var title: String
    var body: String
    
    // ❌ 1️⃣ Run without #Index macro
    // #Index<LinkedinPost>([\.title])
    // Post.count: 100000 - Average fetch time: 3.4338098764419556 ms
    
    // ✅ 2️⃣ Run with #Index macro
    #Index<LinkedinPost>([\.title])
    // Post.count: 100000 - Average fetch time: 0.20980000495910645 ms

    init(id: UUID = UUID(), title: String, body: String = "") {
        self.id = id
        self.title = title
        self.body = body
    }
}

struct IndexMacroView: View {
    @Environment(\.modelContext) var context
    @Query private var posts: [LinkedinPost]
    var body: some View {
        Text("IndexMacroView")
            .task {
                try? seed()
                try? benchmark()
            }
    }
    
    func seed() throws {
        for i in 0..<100_000 {
            let value = (i < 10) ? "Nikola Tesla" : "Random \(i)"
            context.insert(LinkedinPost(title: value))
        }
        try context.save()
    }
    
    func benchmark(iterations: Int = 200) throws {
        let search = "Nikola Tesla"
        wormup(search: search)
        
        let start = CFAbsoluteTimeGetCurrent()
        for _ in 0..<iterations {
            let descriptor = FetchDescriptor<LinkedinPost>(
                predicate: #Predicate { $0.title == search }
            )
            _ = try context.fetch(descriptor)
        }
        
        let end = CFAbsoluteTimeGetCurrent()
        let avg = (end - start) / Double(iterations)
        print("Post.count: \(posts.count) - Average fetch time: \(avg * 1000) ms")
    }
    
    func wormup(search: String) {
        // warm-up
        for _ in 0..<10 {
            let d = FetchDescriptor<LinkedinPost>(
                predicate: #Predicate { $0.title == search }
            )
            _ = try? context.fetch(d)
        }
    }
}
