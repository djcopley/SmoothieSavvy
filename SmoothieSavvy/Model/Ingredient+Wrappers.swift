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
    
    var nameBinding: Binding<String> {
        Binding {
            self.name
        } set: { newValue in
            self.name = newValue
        }
    }
    
    var emojiBinding: Binding<Emoji> {
        Binding {
            return Emoji(value: self.emoji, name: "")
        } set: { newEmoji in
            self.emoji = newEmoji.value
        }
    }

    var sortedRecipes: [Recipe] {
        return (recipes as? Set<Recipe> ?? []).sorted { $0.name < $1.name }
    }
}
