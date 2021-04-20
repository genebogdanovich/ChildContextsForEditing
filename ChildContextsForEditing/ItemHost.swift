//
//  ItemHost.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 20.04.21.
//

// This view serves as a detail as well as the editor of item.

import SwiftUI

struct ItemHost: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.managedObjectContext) private var childContext
    @ObservedObject var item: Item
    
    var body: some View {
        VStack {
            if isEditing {
                // Editor
                Form {
                    Section {
                        // Make sure to set default empty string on `name` attribute in model editor or else it will crash.
                        TextField("Title", text: $item.title.optionalProxy()!)
                    }
                }
            } else {
                // Detail
                Text(item.title ?? "Unknown Item")
                    .font(.title)
                    .padding()
                Spacer()
            }
        }
        .navigationBarTitle(isEditing ? "Editor" : "Item", displayMode: .inline)
        .navigationBarItems(leading: cancelButton, trailing: saveButton)
    }
    
    // MARK: Views
    
    private var saveButton: some View {
        Button(action: saveChanges) {
            Text(isEditing ? "Save" : "Edit")
        }
        .disabled(item.title!.isEmpty)
    }
    
    private var cancelButton: some View {
        Button(action: cancelChanges) {
            if isEditing {
                Text("Cancel")
            } else {
                EmptyView()
            }
        }
    }
    
    // MARK: Helpers
    
    private func saveChanges() {
        try! childContext.save()
        toggleEditingMode()
    }
    
    private func cancelChanges() {
        childContext.refresh(item, mergeChanges: false)
        toggleEditingMode()
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    private func toggleEditingMode() {
        editMode?.animation().wrappedValue = isEditing ? .inactive : .active
    }
}
