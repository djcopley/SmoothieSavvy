//
//  GridView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

enum FilterOption: String, CaseIterable {
    case all, favorites
}

struct DiscoverView: View {
    @EnvironmentObject var recipeManager: RecipeManager

    let columns = [GridItem(.adaptive(minimum: 175))]
    
    @State private var filterMode = FilterOption.all
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView {
                    Image("example")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(recipeManager.filteredRecipes(searchText)) { $recipe in
                            NavigationLink {
                                SmoothieView(recipe: $recipe)
                            } label: {
                                DiscoverItemView(recipe: recipe)
                            }
                        }
                    }
                    .padding()
                }
                .searchable(text: $searchText)
                .navigationTitle("SmoothieSavvy")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker(selection: $filterMode, label: Text("Filter options")) {
                                Label("All", systemImage: "list.bullet")
                                    .tag(FilterOption.all)
                                Label("Favorites Only", systemImage: "heart")
                                    .tag(FilterOption.favorites)
                            }
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle")
                        }
                    }
                }
            }
            .background(BackgroundView())
        }
    }
}

struct RecipesGridView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(RecipeManager())
    }
}
