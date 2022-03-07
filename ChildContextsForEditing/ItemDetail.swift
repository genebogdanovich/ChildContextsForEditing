//
//  ItemDetail.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 7.03.22.
//

import SwiftUI

struct ItemDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var itemUpdateOperation: UpdateOperation<Item>?
    
    @ObservedObject var item: Item
    
    var body: some View {
        Form {
            Section {
                Text(item.title ?? "")
            }
        }
        .navigationTitle("Item")
        .toolbar {
            Button("Update") {
                itemUpdateOperation = UpdateOperation(withExistingObject: item, in: viewContext)
            }
        }
        .sheet(item: $itemUpdateOperation) { updateOperation in
            NavigationView {
                ItemEditor(item: updateOperation.childObject)
                    .navigationTitle("Update Item")
            }
            .environment(\.managedObjectContext, updateOperation.childContext)
        }
    }
}
