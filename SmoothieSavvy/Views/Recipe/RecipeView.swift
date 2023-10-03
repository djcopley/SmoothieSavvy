//
//  RecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct RecipeView: View {
    @Bindable var recipe: Recipe
    
    @Environment(\.editMode) private var editMode
    @Environment(\.colorScheme) private var colorScheme
    @State private var editViewIsPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HeaderSection(recipe: recipe)
                InfoSection(info: recipe.info)
                IngredientsSection(ingredients: recipe.ingredients)
                DirectionsSection(directions: recipe.directions)
                NotesSection(notes: recipe.notes)
                RelatedSmoothiesSection(relatedRecipes: relatedRecipes)
            }
        }
        .sheet(isPresented: $editViewIsPresented) {
            RecipeEditor(recipe: recipe)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") { editViewIsPresented = true }
            }
        }
        .navigationTitle(recipe.name)
        .background(LinearGradientBackground())
    }

    var relatedRecipes: [Recipe] {
        return []
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = PreviewSampleData.container
        
        return RecipeView(recipe: .greenDetoxSmoothie)
            .modelContainer(container)
    }
}
