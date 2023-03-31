//
//  Recipe+Wrappers.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/27/23.
//

import CoreData
import UIKit

extension Recipe {
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }
    
    var uiImage: UIImage? {
        get {
            guard let imageData = imageData else {
                return nil
            }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.pngData()
        }
    }
    
    var name: String {
        get {
            return name_!
        } set {
            name_ = newValue
        }
    }
        
    var directions: [String] {
        get {
            return directions_ ?? []
        } set {
            directions_ = newValue
        }
    }
    
    var sortedIngredients: [Ingredient] {
        let ingredients = ingredients as? Set<Ingredient> ?? []
        return ingredients.sorted { $0.name < $1.name }
    }
    
    var sortedTags: [Tag] {
        let tags = tags as? Set<Tag> ?? []
        return tags.sorted { $0.name < $1.name }
    }
}
