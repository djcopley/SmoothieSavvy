//
//  NotesSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct NotesSection: View {
    var notes: String
    
    @Environment(\.colorScheme) var colorScheme
    private var accentColor: Color { colorScheme == .dark ? .darkBgAccent : .lightBgAccent }
    
    var body: some View {
        if !notes.isEmpty {
            RecipeSection("Notes") {
                Text(notes)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 150, alignment: .top)
                    .background(accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal)
        }
    }
}
