//
//  Recipe.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import Foundation

struct SmoothieRecipe: Identifiable, Hashable, Codable {
    var id: String { name }
    var name: String
    var description: String
    var directions: [String]
    var ingredientMeasurements: [String]
    var ingredients: [Ingredient] = []
    var decoration: String?
    var imageAssetName: String = "defaultSmoothie"
    var tags: [String] = []
}
