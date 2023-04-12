//
//  Ingredient+Wrappers.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/27/23.
//

import CoreData
import SwiftUI
import EmojiPicker

extension Ingredient {
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.emoji = .randomEmoji
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
    
    var emoji: String {
        get {
            emoji_!
        } set {
            emoji_ = newValue
        }
    }

    var sortedRecipes: [Recipe] {
        return (recipes as? Set<Recipe> ?? []).sorted { $0.name < $1.name }
    }
}
