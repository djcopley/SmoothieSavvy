//
//  DirectionsSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct DirectionsSection: View {
    var directions: [String]

    var body: some View {
        if !directions.isEmpty {
            RecipeSection("Directions") {
                ForEach(directions.enumeratedArray(), id: \.element) { (offset, element) in
                    DirectionView(index: offset + 1, description: element)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct DirectionView: View {
    var index: Int
    var description: String

    var body: some View {
        HStack(alignment: .top) {
            Text("\(index). ")
            Text(description)
        }
    }
}
