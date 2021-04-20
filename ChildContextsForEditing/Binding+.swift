//
//  Binding+.swift
//  ChildContextsForEditing
//
//  Created by Gene Bogdanovich on 20.04.21.
//

import SwiftUI

extension Binding {
    func optionalProxy<Wrapped>() -> Binding<Wrapped>? where Value == Optional<Wrapped> {
        guard let value = self.wrappedValue else { return nil }
        
        return Binding<Wrapped>(
            get: {
                value
            },
            set: {
                self.wrappedValue = $0
            }
        )
    }
}
