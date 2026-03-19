//
//  User.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 19. 3. 2026..
//

import Foundation
import SwiftData

@Model
final class User {
    var info: String
    var title: String
    var createdAt: Date
    @Attribute(.ephemeral)
    @Attribute(.externalStorage)
    @Attribute(.allowsCloudEncryption)
    @Attribute(.unique)
    var friends: [User]

    init(
        title: String = "b",
        info: String = "a",
        createdAt: Date = .now,
        friends: [User] = []
    ) {
        self.title = title
        self.info = info
        self.createdAt = createdAt
        self.friends = friends
    }
}
