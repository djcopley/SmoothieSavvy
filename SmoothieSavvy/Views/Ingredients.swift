//
//  IngredientsView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct Ingredients: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Text("No results found for '\(searchText)'")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Background())
                .searchable(text: $searchText)
                .navigationTitle("Ingredients")
        }
    }
}

struct Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        Ingredients()
    }
}
