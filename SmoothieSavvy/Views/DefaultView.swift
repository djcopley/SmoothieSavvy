//
//  DefaultView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/21/23.
//

import SwiftUI

struct DefaultView<Content: View, Default: View>: View {
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

//struct DefaultView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultView()
//    }
//}
