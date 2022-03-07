//
//  ChildContextsForEditingApp.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 20.04.21.
//

import SwiftUI

@main
struct ChildContextsForEditingApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ItemList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    try? persistenceController.container.viewContext.save()
                }
        }
    }
}
