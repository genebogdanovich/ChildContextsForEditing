//
//  ItemList.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 20.04.21.
//

import SwiftUI
import CoreData

struct ItemList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var items: FetchedResults<Item>
    @State private var itemCreateOperation: CreateOperation<Item>?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink {
                        ItemDetail(item: item)
                    } label: {
                        Text(item.title ?? "")
                    }
                }
            }
            .navigationTitle("Items")
            .toolbar {
                plusButton
            }
            .sheet(item: $itemCreateOperation) { createOperation in
                NavigationView {
                    ItemEditor(item: createOperation.childObject)
                        .navigationTitle("New Item")
                }
                .environment(\.managedObjectContext, createOperation.childContext)
            }
        }
    }
    
    // MARK: Views
    
    private var plusButton: some View {
        Button(action: {
            itemCreateOperation = CreateOperation(with: viewContext)
        }) {
            Label("Add Item", systemImage: "plus")
        }
    }
}
