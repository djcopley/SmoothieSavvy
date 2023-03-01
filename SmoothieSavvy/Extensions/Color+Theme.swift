//
//  Color+Theme.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/28/23.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

struct Color_Theme_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.lightBackground
                Color.darkBackground
            }
            .ignoresSafeArea()
            
            Text("Background Color")
                .foregroundColor(.white)
            
        }
    }
}
