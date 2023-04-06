//
//  Ingredient+Wrappers.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/27/23.
//

import CoreData

extension Ingredient {
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }

    convenience init(name: String, emoji: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.emoji = emoji
    }
    
    var name: String {
        get {
            name_!
        } set {
            name_ = newValue
        }
    }
}
