//
//  Recipe.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import Foundation
import UniformTypeIdentifiers

struct SmoothieRecipe: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var directions: [String] = []
    var ingredientMeasurements: [String] = []
    var ingredients: [Ingredient] = []
    var decoration: String?
    var imageAssetName: String = "defaultSmoothie"
    var tags: [String] = []
    var notes: String = ""
    var isFavorite: Bool = false
}

extension UTType {
    static let smoothieRecipe: UTType = UTType(exportedAs: "dev.copley.smoothie-recipe")
}
