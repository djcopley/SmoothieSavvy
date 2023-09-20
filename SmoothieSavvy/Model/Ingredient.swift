//
//  SmoothieIngredient.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftData

@Model
class Ingredient {
    @Attribute(.unique) var name: String
    var emoji: String
    
    var recipe: Recipe?
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
    }
}
