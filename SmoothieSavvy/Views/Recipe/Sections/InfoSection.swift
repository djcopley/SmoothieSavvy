//
//  InfoSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct InfoSection: View {
    var info: String

    var body: some View {
        if !info.isEmpty {
            Text(info)
                .padding(.horizontal)
        }
    }
}
