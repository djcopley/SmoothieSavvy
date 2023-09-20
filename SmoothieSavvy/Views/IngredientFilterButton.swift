//
//  IngredientFilterButton.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct IngredientFilterButton: View {
    @Binding var ingredientFilterIsPresented: Bool
    
    var body: some View {
        Button {
            ingredientFilterIsPresented = true
        } label: {
            Label("Ingredient Filter", systemImage: "line.3.horizontal.decrease")
        }
    }
}

#Preview {
    IngredientFilterButton(ingredientFilterIsPresented: .constant(false))
}
