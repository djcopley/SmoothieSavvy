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
            Recipe.greenDetoxSmoothie,
            Recipe.strawberryBananaSmoothie,
            Recipe.mangoPineappleSmoothie,
            Recipe.chocolateBananaPeanutButterSmoothie,
            Recipe.berryBlastSmoothie,
            Recipe.tropicalCoconutMangoSmoothie,
            Recipe.appleSpinachKiwiSmoothie,
            Recipe.avocadoBananaSpinachSmoothie,
        ]
        Task { @MainActor in
            sampleData.forEach {
                container.mainContext.insert($0)
            }
        }
        return container
    }
}

// Default smoothies for use in previews.
extension Recipe {
    static var greenDetoxSmoothie: Recipe {
        let recipe = Recipe(
            name: "Green Detox Smoothie",
            isFavorite: true,
            directions: [
                "Blend Spinach, Kale, Pineapple, Banana, and Coconut Water until smooth.",
                "Add a handful of ice and blend again for a refreshing chill.",
                "Pour into a glass and enjoy this healthy detox drink!"
            ],
            info: "A nutritious and cleansing green smoothie.",
            notes: "Feel free to add a scoop of protein powder for extra nutrition."
        )
        recipe.ingredients = [
            Ingredient(name: "Spinach", emoji: "🍃"),
            Ingredient(name: "Kale", emoji: "🥬"),
            Ingredient(name: "Pineapple", emoji: "🍍"),
            Ingredient(name: "Banana", emoji: "🍌"),
            Ingredient(name: "Coconut Water", emoji: "🥥"),
            Ingredient(name: "Ice", emoji: "❄️")
        ]
        return recipe
    }

    static var strawberryBananaSmoothie: Recipe {
        let recipe = Recipe(
            name: "Strawberry Banana Smoothie",
            isFavorite: false,
            directions: [
                "Combine Strawberries, Bananas, Greek Yogurt, Honey, and Ice in a blender.",
                "Blend until smooth and creamy.",
                "Pour into a glass and enjoy!"
            ],
            info: "A classic and refreshing smoothie.",
            notes: "Adjust sweetness with more or less honey based on your preference."
        )
        recipe.ingredients = [
            Ingredient(name: "Strawberries", emoji: "🍓"),
            Ingredient(name: "Bananas", emoji: "🍌"),
            Ingredient(name: "Greek Yogurt", emoji: "🥄"),
            Ingredient(name: "Honey", emoji: "🍯"),
            Ingredient(name: "Ice", emoji: "❄️")
        ]
        return recipe
    }

    static var mangoPineappleSmoothie: Recipe {
        let recipe = Recipe(
            name: "Mango Pineapple Smoothie",
            isFavorite: true,
            directions: [
                "Blend Mango, Pineapple, Coconut Milk, and a squeeze of Lime Juice until smooth.",
                "Add a handful of ice and blend for a tropical chill.",
                "Pour into a glass and garnish with a pineapple slice."
            ],
            info: "A taste of the tropics in a glass.",
            notes: "You can use fresh or frozen fruit for this recipe."
        )
        recipe.ingredients = [
            Ingredient(name: "Mango", emoji: "🥭"),
            Ingredient(name: "Pineapple", emoji: "🍍"),
            Ingredient(name: "Coconut Milk", emoji: "🥥"),
            Ingredient(name: "Lime Juice", emoji: "🍋"),
            Ingredient(name: "Ice", emoji: "❄️")
        ]
        return recipe
    }

    static var chocolateBananaPeanutButterSmoothie: Recipe {
        let recipe = Recipe(
            name: "Chocolate Banana Peanut Butter Smoothie",
            isFavorite: false,
            directions: [
                "Combine Bananas, Cocoa Powder, Peanut Butter, Almond Milk, and a drizzle of Honey in a blender.",
                "Blend until creamy and rich in flavor.",
                "Pour into a glass and enjoy this indulgent treat!"
            ],
            info: "A satisfying blend of chocolate and nutty goodness.",
            notes: "Add a pinch of salt for a flavor boost."
        )
        recipe.ingredients = [
            Ingredient(name: "Bananas", emoji: "🍌"),
            Ingredient(name: "Cocoa Powder", emoji: "🍫"),
            Ingredient(name: "Peanut Butter", emoji: "🥜"),
            Ingredient(name: "Almond Milk", emoji: "🥛"),
            Ingredient(name: "Honey", emoji: "🍯")
        ]
        return recipe
    }

    static var berryBlastSmoothie: Recipe {
        let recipe = Recipe(
            name: "Berry Blast Smoothie",
            isFavorite: true,
            directions: [
                "Blend Strawberries, Blueberries, Raspberries, Greek Yogurt, and Orange Juice until smooth.",
                "Add a handful of ice and blend again for extra chill.",
                "Pour into a glass and savor the burst of berry flavors!"
            ],
            info: "A colorful and antioxidant-rich smoothie.",
            notes: "Use frozen mixed berries for convenience."
        )
        recipe.ingredients = [
            Ingredient(name: "Strawberries", emoji: "🍓"),
            Ingredient(name: "Blueberries", emoji: "🫐"),
            Ingredient(name: "Raspberries", emoji: "🍇"),
            Ingredient(name: "Greek Yogurt", emoji: "🥄"),
            Ingredient(name: "Orange Juice", emoji: "🍊"),
            Ingredient(name: "Ice", emoji: "❄️")
        ]
        return recipe
    }

    static var tropicalCoconutMangoSmoothie: Recipe {
        let recipe = Recipe(
            name: "Tropical Coconut Mango Smoothie",
            isFavorite: true,
            directions: [
                "Blend Mango, Pineapple, Coconut Milk, and a splash of Coconut Cream until creamy.",
                "Add crushed ice for an island-style refreshment.",
                "Pour into a glass and enjoy the tropical vibes!"
            ],
            info: "A taste of the beach in a smoothie.",
            notes: "Garnish with shredded coconut for extra flair."
        )
        recipe.ingredients = [
            Ingredient(name: "Mango", emoji: "🥭"),
            Ingredient(name: "Pineapple", emoji: "🍍"),
            Ingredient(name: "Coconut Milk", emoji: "🥥"),
            Ingredient(name: "Coconut Cream", emoji: "🥥"),
            Ingredient(name: "Crushed Ice", emoji: "❄️")
        ]
        return recipe
    }
    
    static var appleSpinachKiwiSmoothie: Recipe {
        let recipe = Recipe(
            name: "Apple Spinach Kiwi Smoothie",
            isFavorite: true,
            directions: [
                "Combine Apple, Spinach, Kiwi, Greek Yogurt, and a drizzle of Honey in a blender.",
                "Blend until it's a vibrant green and smooth.",
                "Pour into a glass and enjoy this nutritious green delight!"
            ],
            info: "A healthy and refreshing green smoothie.",
            notes: "You can add a splash of apple juice for extra sweetness."
        )
        recipe.ingredients = [
            Ingredient(name: "Apple", emoji: "🍏"),
            Ingredient(name: "Spinach", emoji: "🍃"),
            Ingredient(name: "Kiwi", emoji: "🥝"),
            Ingredient(name: "Greek Yogurt", emoji: "🥄"),
            Ingredient(name: "Honey", emoji: "🍯")
        ]
        return recipe
    }
    
    static var avocadoBananaSpinachSmoothie: Recipe {
        let recipe = Recipe(
            name: "Avocado Banana Spinach Smoothie",
            isFavorite: true,
            directions: [
                "Blend Avocado, Banana, Spinach, Almond Milk, and a squeeze of Lemon Juice until creamy.",
                "Add a handful of ice for extra freshness.",
                "Pour into a glass and enjoy this green powerhouse!"
            ],
            info: "A nutrient-packed green smoothie.",
            notes: "Feel free to add a spoonful of chia seeds for extra fiber and Omega-3s."
        )
        recipe.ingredients = [
            Ingredient(name: "Avocado", emoji: "🥑"),
            Ingredient(name: "Banana", emoji: "🍌"),
            Ingredient(name: "Spinach", emoji: "🍃"),
            Ingredient(name: "Almond Milk", emoji: "🥛"),
            Ingredient(name: "Lemon Juice", emoji: "🍋"),
            Ingredient(name: "Ice", emoji: "❄️")
        ]
        return recipe
    }
}
