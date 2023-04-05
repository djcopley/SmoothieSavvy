//
//  RecipeSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/20/23.
//

import SwiftUI

struct RecipeSection<Content: View>: View {
    var name: String
    @ViewBuilder var content: () -> Content
    
    init(_ name: String, @ViewBuilder content: @escaping () -> Content) {
        self.name = name
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            Text(name)
                .font(.headline)
            
            content()
        }
    }
    
    var alignment = HorizontalAlignment.leading
    var spacing: CGFloat = 10
}

struct RecipeSection_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSection("Test") {
            Text("This is the text")
        }
    }
}
