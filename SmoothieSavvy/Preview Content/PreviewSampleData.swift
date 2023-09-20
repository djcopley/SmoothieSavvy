//
//  PreviewSampleData.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI
import SwiftData

/// An actor that provides an in-memory model container for previews.
actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        return try! inMemoryContainer()
    }()

    static var inMemoryContainer: () throws -> ModelContainer = {
        let schema = Schema([Recipe.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            Recipe.xxsmall,
            Recipe.xsmall,
            Recipe.small,
            Recipe.medium,
            Recipe.large,
            Recipe.xlarge,
            Recipe.xxlarge,
            Recipe.xxxlarge,
        ]
        Task { @MainActor in
            sampleData.forEach {
                container.mainContext.insert($0)
            }
        }
        return container
    }
}

// Default quakes for use in previews.
extension Recipe {
    static var xxsmall: Recipe {
        let recipe = Recipe(
            name: "Banana Smoothie",
            isFavorite: true,
            directions: [
                "Load the blender with Bananas, Kiwi, Milk, Orange Juice, and Peanut butter",
                "Add ice cubes on top",
                "Run the blender until the smoothie has a smooth texture"
            ],
            info: "A delicious, summery fun smoothie",
            notes: "It was a little too runny when I made it this time. Try adding yogurt next time. That might help thicken it up."
        )
        recipe.ingredients = [Ingredient(name: "Cucumber", emoji: "🥒")]
        return recipe
    }
    static var xsmall: Recipe {
        Recipe(name: "Banana 2", notes: "This is a test.")
    }
    static var small: Recipe {
        Recipe(name: "Banana 3")
    }
    static var medium: Recipe {
        Recipe(name: "Banana 4")
    }
    static var large: Recipe {
        Recipe(name: "Banana 5")
    }
    static var xlarge: Recipe {
        Recipe(name: "Banana 6")
    }
    static var xxlarge: Recipe {
        Recipe(name: "Banana 7")
    }
    static var xxxlarge: Recipe {
        Recipe(name: "Banana 8")
    }
}
