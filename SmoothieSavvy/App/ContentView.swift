//
//  TestView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        NavigationSplitView {
            RecipesSidebarView(selectedRecipe: $selectedRecipe)
        } detail: {
            if let selectedRecipe = selectedRecipe {
                SmoothieRecipeView(recipe: selectedRecipe)
            } else {
                noSelectedRecipe
            }
        }
    }
    
    @ViewBuilder
    private var noSelectedRecipe: some View {
        Text("No Recipe Selected")
            .font(.title2)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradientBackground())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
