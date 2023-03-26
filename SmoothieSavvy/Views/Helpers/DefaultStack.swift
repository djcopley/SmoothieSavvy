//
//  DefaultView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/21/23.
//

import SwiftUI

struct DefaultStack<Content: View, Default: View>: View {
    var defaultIsPresented: Bool
    @ViewBuilder var `default`: () -> Default
    @ViewBuilder var content: () -> Content
    
    init(when defaultIsPresented: Bool, show `default`: @escaping () -> Default, content: @escaping () -> Content) {
        self.defaultIsPresented = defaultIsPresented
        self.`default` = `default`
        self.content = content
    }
    
    var body: some View {
        if defaultIsPresented {
            `default`()
        } else {
            content()
        }
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DefaultStack(when: true) {
                Text("Default")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
            } content: {
                Text("Default")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
            }
            
            DefaultStack(when: false) {
                Text("Default")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
            } content: {
                Text("Content")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
            }
        }
    }
}
