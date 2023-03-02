//
//  IngredientsView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct IngredientsView: View {
    var body: some View {
        Text("Ingredients")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
