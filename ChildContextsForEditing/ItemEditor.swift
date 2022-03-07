//
//  ItemEditor.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 7.03.22.
//

import SwiftUI

struct ItemEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var childContext
    
    @ObservedObject var item: Item
    
    var body: some View {
        Form {
            Section {
                if let title = Binding($item.title) {
                    TextField("Title", text: title)
                }
            }
        }
        .toolbar {
            Button() {
                try? childContext.save()
                dismiss()
            } label: {
                Text("Save")
            }
        }
    }
}
