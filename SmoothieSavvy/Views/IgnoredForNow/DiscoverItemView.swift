//
//  GridItemView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/28/23.
//

import SwiftUI

struct DiscoverItemView: View {
    var recipe: SmoothieRecipe
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.thickMaterial)
                .frame(height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .center) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text("\(recipe.ingredients.count) ingredients")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            DiscoverItemView(recipe: SmoothieRecipeData().recipes[0])
        }
    }
}
