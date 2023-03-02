//
//  Ingredient.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import Foundation
import SwiftUI

struct RawIngredient: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
}

extension RawIngredient {
    static let rawIngredients = [apple, blueberry]
    
    static let apple = RawIngredient(name: "apple")
    static let blueberry = RawIngredient(name: "blueberry")
}

struct RecipeIngredient {
    var ingredient: RawIngredient
    var displayName: String
}
