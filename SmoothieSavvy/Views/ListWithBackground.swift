//
//  ListWithBackground.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/12/23.
//

import SwiftUI

struct ListWithBackground<Item: Identifiable, DefaultContent: View, RowContent: View>: View {
    var items: [Item]
    var defaultView: DefaultContent
    @ViewBuilder var rowContent: (Item) -> RowContent
    
    init(_ items: [Item], defaultView: DefaultContent, @ViewBuilder rowContent: @escaping (Item) -> RowContent) {
        self.items = items
        self.defaultView = defaultView
        self.rowContent = rowContent
    }
    
    var body: some View {
        Group {
            if items.isEmpty {
                defaultView
            } else {
                List(items, rowContent: rowContent)
                    .scrollContentBackground(.hidden)
            }
        }
        .background(BackgroundView())
    }
}

struct ListWithBackground_Previews: PreviewProvider {
    @StateObject static private var recipeData = SmoothieRecipeData()
    
    static var previews: some View {
        NavigationStack {
            ListWithBackground(recipeData.recipes, defaultView: Text("Testing")) { item in
                NavigationLink(item.name, value: item)
            }
        }
    }
}
