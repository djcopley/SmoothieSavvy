//
//  BackgroundView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/28/23.
//

import SwiftUI

struct GradientBackground: View {
    @Environment(\.colorScheme) var colorScheme
    
    func bgGradient(_ radius: CGFloat) -> RadialGradient {
        let lightStops: [Gradient.Stop] = [
            .init(color: .lightBgAccent, location: 0.0),
            .init(color: .lightBgBase, location: 1.0)
        ]
        let darkStops: [Gradient.Stop] = [
            .init(color: .darkBgAccent, location: 0.0),
            .init(color: .darkBgBase, location: 1.0)
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
        GradientBackground()
    }
}
