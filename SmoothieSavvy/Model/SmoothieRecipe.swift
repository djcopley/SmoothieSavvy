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
    var ingredients: [String]
    var decoration: String?
    var image = "defaultSmoothie"
    var tags: [String] = []
}
