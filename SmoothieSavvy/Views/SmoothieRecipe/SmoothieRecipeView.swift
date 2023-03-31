//
//  SmoothieView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

struct SmoothieRecipeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var recipe: Recipe
    
    @FocusState var notesIsFocused
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 150))]
    
    private var accentColor: Color {
        colorScheme == .dark ? .darkBgAccent : .lightBgAccent
    }
    
    private let tempSmoothieImageName = "defaultSmoothie"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HeaderImage(recipe: recipe)
                    .padding(.horizontal)

                if let info = recipe.info {
                    Text(info)
                        .padding(.horizontal)
                }
                
                if !recipe.sortedIngredients.isEmpty {
                    RecipeSection("Ingredients") {
                        LazyVGrid(columns: columns) {
                            ForEach(recipe.sortedIngredients) { ingredient in
                                ZStack {
                                    Color.clear
                                        .background(accentColor)
                                        .clipShape(Capsule())

                                    
                                    Text("\(ingredient.emoji) \(ingredient.name)")
                                        .lineLimit(1)
                                        .padding(8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                if !recipe.directions.isEmpty {
                    RecipeSection("Directions") {
                        ForEach(recipe.directions.enumeratedArray(), id: \.element) { (offset, element) in
                            HStack(alignment: .top) {
                                Text("\(offset + 1). ")
                                Text(element)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                RecipeSection("Notes") {
                    TextEditor(text: $recipe.notes.with(default: ""))
                        .focused($notesIsFocused)
                        .scrollContentBackground(.hidden)
                        .background(accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(height: 150)
                }
                .padding(.horizontal)

//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Related Smoothies")
//                        .font(.headline)
//                        .padding(.horizontal)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(relatedRecipes) { relatedRecipe in
//                                SmoothieThumbnail(recipe: relatedRecipe)
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
            }
        }
//        .toolbar {
//            ShareLink(item: recipe, preview: SharePreview(recipe.name, image: Image(recipe.imageAssetName)))
//        }
        .toolbar {
            if notesIsFocused {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        notesIsFocused = false
                    }
                }
            }
        }
        .navigationTitle(recipe.name)
        .background(GradientBackground())
    }
    
//    /// Recommends a list of smoothie recipes that are similar
//    /// - Parameter recipe: recipe from which to generate recommendations
//    /// - Returns: similar smoothie recommendations
//    var relatedRecipes: [Recipe] {
//        recipes
//    }
}

// MARK: Previews
//struct Smoothie_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SmoothieRecipeView(recipe: .constant(.breakfastSmoothie))
//        }
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        .previewDisplayName("Rise & Shine")
//
//        
//        NavigationStack {
//            SmoothieRecipeView(recipe: .constant(.breakfastBar))
//        }
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        .previewDisplayName("Banana Breakfast Shake")
//    }
//}
