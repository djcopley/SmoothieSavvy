//
//  IngredientsView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct IngredientsView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Text("No results found for '\(searchText)'")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundView())
                .searchable(text: $searchText)
                .navigationTitle("Ingredients")
        }
    }
}

struct Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
