//
//  UniqeMacro.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 20. 3. 2026..
//

import Foundation
import SwiftData



// user_1 has Sword lvl 1
// user_2 has Sword lvl 1
// user_2 upgraded his Sword to lvl 2
// how do we sync that without touching user_1's Sword?

// ❌ Old way — synthetic ID
@Model
final class Item {
    var id: String
    var userId: String
    var itemName: String
    var lvl: Int = 1

    init(userId: String, itemName: String, lvl: Int) {
        self.id = "\(userId)-\(itemName)" // fragile, hard to query
        self.userId = userId
        self.itemName = itemName
        self.lvl = lvl
    }
}

// So for upsert you need to fetch exactly one you need, and then update data.

// ✅ New way — #Unique
@Model
final class Item {
    #Unique<Item>([\.userId, \.itemName])

    var userId: String
    var itemName: String
    var lvl: Int = 1

    init(userId: String, itemName: String, lvl: Int) {
        self.userId = userId
        self.itemName = itemName
        self.lvl = lvl
    }
}

// Server tells us user_2 upgraded his Sword to lvl 2
// Just insert — SwiftData finds user_2 + Sword and updates lvl
// user_1's Sword stays untouched ✅
context.insert(Item(userId: "user_2", itemName: "Sword", lvl: 2))

// Result:
// user_1 | Sword | lvl 1  ← untouched ✅
// user_2 | Sword | lvl 2  ← updated ✅



