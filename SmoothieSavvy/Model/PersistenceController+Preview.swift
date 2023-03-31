//
//  PersistenceController+Preview.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/28/23.
//

import CoreData

extension PersistenceController {
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        
        // Generate test data
        generatePreviewData(context)
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()
    
    private static func generatePreviewData(_ context: NSManagedObjectContext) {
        // MARK: Banana Breakfast Shake
        let bananaBreakfastShake = Recipe(name: "Banana Breakfast Shake", context: context)
        bananaBreakfastShake.info = "Get your day off to a healthy start with this quick but nutritious banana shake. Bananas are a great source of potassium, which is said to play a role in controlling high blood pressure."
        bananaBreakfastShake.isFavorite = true
//        let bananaBreakfastShakeStep1 = Direction(step: "Put the bananas, yogurt, skim milk, and vanilla extract into a food processor or blender and process until smooth.", context: context)
//        bananaBreakfastShake.addToDirections(bananaBreakfastShakeStep1)
        let peanutButter = Ingredient(name: "Peanut Butter", emoji: "🥜", context: context)
        bananaBreakfastShake.addToIngredients(peanutButter)
        
        // MARK: Breakfast Bar Smoothie
        let breakfastBar = Recipe(name: "Breakfast Bar", context: context)
        breakfastBar.info = "Fruity drinks provide a great pick-me-up at any time of day and are perfect for giving an energy boost first thing in the morning."
        let grapefruit = Ingredient(name: "Grapefruit", emoji: "🍊", context: context)
        let orange = Ingredient(name: "Orange", emoji: "🍊", context: context)
        let lemon = Ingredient(name: "Lemon", emoji:"🍋", context: context)
        let lime = Ingredient(name: "Lime", emoji: "🫒", context: context)
        breakfastBar.addToIngredients(grapefruit)
        breakfastBar.addToIngredients(orange)
        breakfastBar.addToIngredients(lemon)
        breakfastBar.addToIngredients(lime)
//        let breakfastBarStep1 = Direction(step: "Tip the canned fruit and the can juices into a food process or blender.", context: context)
//        let breakfastBarStep2 = Direction(step: "Add the lemon, lime, and orange juice and process until smooth.", context: context)
//        let breakfastBarStep3 = Direction(step: "Pour into chilled glasses and serve.", context: context)
//        breakfastBar.addToDirections(breakfastBarStep1)
//        breakfastBar.addToDirections(breakfastBarStep2)
//        breakfastBar.addToDirections(breakfastBarStep3)
    }
}
