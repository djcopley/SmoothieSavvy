//
//  Background.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/28/23.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    
    func bgGradient(_ radius: CGFloat) -> RadialGradient {
        let lightStops: [Gradient.Stop] = [
            .init(color: Color(red: 0.8, green: 1.0, blue: 0.95), location: 0.0),
            .init(color: Color(red: 0.6, green: 1.0, blue: 0.85), location: 1.0)
        ]
        let darkStops: [Gradient.Stop] = [
            .init(color: Color(red: 0.3, green: 0.0, blue: 0.4), location: 0.0),
            .init(color: Color(red: 0.24, green: 0.0, blue: 0.43), location: 1.0),
        ]
        let stops = colorScheme == .light ? lightStops : darkStops
        
        return RadialGradient(stops: stops, center: .top, startRadius: radius - 50, endRadius: radius + 50)
    }
    
    
    var body: some View {
        GeometryReader { geo in
            bgGradient(geo.size.width / 2)
        }
        .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
