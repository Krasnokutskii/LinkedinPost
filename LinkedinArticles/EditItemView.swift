//
//  EditItemView.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 21. 3. 2026..
//

import SwiftUI
import SwiftData

struct EditItemView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let item: Item

    var body: some View {
        Form { /* fields bound to item */ }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    context.rollback()   // discard all pending changes
                    context.reset()
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    try? context.save()
                    dismiss()
                }
            }
        }
        .onAppear()
    }
}
