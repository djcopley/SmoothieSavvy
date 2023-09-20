//
//  SmoothieRecipe.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import UIKit
import SwiftData

@Model
class Recipe: Identifiable {
    @Attribute(.unique) var name: String
    @Attribute(.unique) var id: UUID
    var isFavorite: Bool
    var directions: [String]
    var info: String
    var notes: String
    var dateCreated: Date
    @Attribute(.externalStorage) var image: Data?

    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipe) var ingredients = [Ingredient]()

    init(
        name: String,
        id: UUID = UUID(),
        isFavorite: Bool = false,
        directions: [String] = [],
        info: String = "",
        notes: String = "",
        dateCreated: Date = Date.now,
        image: Data? = nil
    ) {
        self.name = name
        self.id = id
        self.isFavorite = isFavorite
        self.directions = directions
        self.info = info
        self.notes = notes
        self.dateCreated = dateCreated
        self.image = image
    }
}

extension Recipe {
    var uiImage: UIImage? {
        get {
            guard let data = image, let uiImage = UIImage(data: data) else {
                return nil
            }
            return uiImage
        }
        set {
            self.image = newValue?.pngData()
        }
    }
}

extension Recipe {
    static func predicate(searchText: String = "", favoritesOnly: Bool = false) -> Predicate<Recipe> {
        return #Predicate{ recipe in searchText.isEmpty || recipe.name.contains(searchText) && (!favoritesOnly || recipe.isFavorite) }
    }
}
