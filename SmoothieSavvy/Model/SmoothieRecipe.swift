//
//  Recipe.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import Foundation

struct SmoothieRecipe: Identifiable, Hashable, Codable {
    var id = UUID()
    var isFavorite = false

    var name: String
    var imageName: String = "defaultSmoothie"
    var description: String
    var decoration: String?
    var directions: [String]
    var ingredients: [String]
}

extension SmoothieRecipe {
    static let bananaBreakfastShake = Self(
        name: "Banana Breakfast Shake",
        description: "Get your day off to a healthy start with this quick but nutritious banana shake. Bananas are a great source of potassium, which is said to play a role in controlling high blood pressure.",
        directions: [
            "Put the bananas, yogurt, skim milk, and vanilla extract into a food processor or blender and process until smooth.",
            "Serve at once."
        ],
        ingredients: ["2 Ripe Bananas", "3/4 Cup Yogurt", "1/2 Cup Skim Milk", "1/2 Tsp Vanilla Extract"])
    
    static let breakfastBar = Self(
        name: "Breakfast Bar",
        description: "Fruity drinks provide a great pick-me-up at any time of day and are perfect for giving an energy boost first thing in the morning.",
        directions: [
            "Tip the canned fruit and the can juices into a food process or blender.",
            "Add the lemon, lime, and orange juice and process until smooth.",
            "Pour into chilled glasses and serve."
        ],
        ingredients: ["14 oz or 400g Canned Grapefruit and Orange Segments", "4 Tbsp Lemon Juice", "3 Tbsp Lime Juice", "Scant 2 Cups Orange Juice, Chilled"]
    )
    
    static let riseAndShine = Self(
        name: "Rise & Shine Juice",
        description: "Vegatables may not be the first thing you think of for a breakfast drink, but this juice is packed with nutrients and is a great way to start your \"Five-A-Day.\"",
        directions: [
            "Put the tomatoes, carrot, and lime juice into processor or blender and process for a few seconds until smooth."
        ],
        ingredients: ["4 Tomatoes, Quartered", "Scant 1/2 Cup Grated Carrot", "1 Tbsp Lime Juice"]
    )
    
    static let breakfastSmoothie = Self(
        name: "Breakfast Smoothie",
        description: "Kick-start your day with this rich vitamin and minteral-packed energizer.",
        decoration: "Whole bananas or slices of banana",
        directions: [
        "Pour the orange juice and yogurt into a food processor or blender and process gently until combined.",
        "Add the eggs and frozen bananas and process until smooth.",
        "Pour the mixture into glasses and decorate the rims with whole bananas or slices of banana. Serve."
        ],
        ingredients: ["1 Cup Orange Juice", "1/2 Cup Plain Yogurt", "2 Eggs"]
    )
    
    static let wakeUpSweetie = Self(
        name: "Wake Up Sweetie",
        description: "",
        decoration: "",
        directions: [""],
        ingredients: []
    )
}
