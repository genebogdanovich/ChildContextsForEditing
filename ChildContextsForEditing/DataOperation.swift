//
//  DataOperation.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 7.03.22.
//

import Foundation
import CoreData

struct CreateOperation<Object: NSManagedObject>: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
    let childObject: Object
    
    init(with parentContext: NSManagedObjectContext) {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = parentContext
        let childObject = Object(context: childContext)
        
        self.childContext = childContext
        self.childObject = childObject
    }
}

struct UpdateOperation<Object: NSManagedObject>: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
    let childObject: Object
    
    init(
        withExistingObject object: Object,
        in parentContext: NSManagedObjectContext
    ) {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = parentContext
        let childObject = childContext.object(with: object.objectID) as! Object
        
        self.childContext = childContext
        self.childObject = childObject
    }
}
