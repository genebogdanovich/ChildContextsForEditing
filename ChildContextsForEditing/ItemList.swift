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
    
    @State private var showingCreation = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(
                        destination: makeItemHost(with: item.objectID),
                        label: {
                            Text(item.title ?? "Unknown Item")
                        })
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Items", displayMode: .inline)
            .navigationBarItems(trailing: plusButton)
            .sheet(isPresented: $showingCreation) {
                makeItemCreationView()
            }
        }
    }
    
    // MARK: Views
    
    private var plusButton: some View {
        Button(action: { showingCreation.toggle() }) {
            Label("Add Item", systemImage: "plus")
        }
    }

    // MARK: Helpers
    
    private func makeItemCreationView() -> some View {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = viewContext
        let childItem = Item(context: childContext)
        return ItemCreationView(item: childItem)
            .environment(\.managedObjectContext, childContext)
    }
    
    private func makeItemHost(with objectID: NSManagedObjectID) -> some View {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = viewContext
        let childItem = childContext.object(with: objectID) as! Item
        return ItemHost(item: childItem)
            .environment(\.managedObjectContext, childContext)
    }
}
