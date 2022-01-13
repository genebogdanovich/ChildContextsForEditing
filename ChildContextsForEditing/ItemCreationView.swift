//
//  ItemCreationView.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 20.04.21.
//

import SwiftUI

struct ItemCreationView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var childContext
    @ObservedObject var item: Item
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: Binding($item.title)!)
                }
            }
            .navigationBarTitle("New Item", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    // MARK: Views
    
    private var saveButton: some View {
        Button(action: saveNewItem) {
            Text("Save")
        }
        .disabled(item.title!.isEmpty)
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // MARK: Helpers
    
    private func saveNewItem() {
        try! childContext.save()
        presentationMode.wrappedValue.dismiss()
    }
}
