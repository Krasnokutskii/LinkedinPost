//
//  0ExampleFetchDescriptor.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 16. 3. 2026..
//

import SwiftUI
import SwiftData



func exampleFetchDescriptor() {
    // Main properties of FetchDescriptor
    
    var descriptor = FetchDescriptor<User>()
    
    descriptor.predicate = #Predicate<User> { user in
        true
    }
    // Filtering:
    // Decides which models should be returned.
    
    descriptor.sortBy = [
        SortDescriptor(\.title, order: .forward),
        SortDescriptor(\.info, order: .forward)
    ]
    // Sorting:
    // You can provide multiple sort descriptors
    // for primary, secondary, ...
    
    descriptor.fetchLimit = 10
    // Limits the maximum number of models returned.
    // Useful when you need only a portion of the result set.
    
    descriptor.fetchOffset = 20
    // Skips the first 20 results.
    // Commonly used for pagination.
    
    // Typical pagination pattern:
    // page 1 -> limit 20, offset 0
    // page 2 -> limit 20, offset 20
    // page 3 -> limit 20, offset 40
    
    descriptor.propertiesToFetch = [\.title, \.info]
    // Fetch only the attributes needed for a specific operation.
    // Useful when you do not need every property.
    
    descriptor.relationshipKeyPathsForPrefetching = [\.friends]
    // Prefetch relationships you know you will access.
    // Helps avoid extra lazy-load fetches later.
    
    descriptor.includePendingChanges = true
    // Includes unsaved in-memory changes from the current ModelContext
    // when the fetch is executed.
    //
    
    
}
