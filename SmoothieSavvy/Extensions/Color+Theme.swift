//
//  Color+Theme.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/28/23.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var lightBgAccent: Color {
        Color(red: 0.8, green: 1.0, blue: 0.95)
    }
    
    static var lightBgBase: Color {
        Color(red: 0.6, green: 1.0, blue: 0.85)
    }
    
    static var darkBgAccent: Color {
        Color(red: 0.3, green: 0.0, blue: 0.4)
    }
    
    static var darkBgBase: Color {
        Color(red: 0.24, green: 0.0, blue: 0.4)
    }
}

struct Color_Theme_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.lightBgBase
                Color.lightBgAccent
                Color.darkBgBase
                Color.darkBgAccent
            }
            .ignoresSafeArea()
            
            Text("Background Color")
                .foregroundColor(.white)
            
        }
    }
}
