//
//  SettingsView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

struct MidAboutAndName: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[.top]
    }
}

extension VerticalAlignment {
    static let midAboutAndName = VerticalAlignment(MidAboutAndName.self)
}

struct SettingsView: View {
    @State private var settings = [""]
        
    var body: some View {
        NavigationStack {
            List {
                Section("About") {
                    HStack(alignment: .midAboutAndName, spacing: 15) {
                        Image("example")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .shadow(radius: 2)
                            .alignmentGuide(.midAboutAndName) { d in d[VerticalAlignment.center] }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("SmoothieSavvy")
                                .font(.title.bold())
                            Group {
                                Text("Made with ❤️ for Turkey")
                            }
                            .font(.subheadline)
                        }
                        .alignmentGuide(.midAboutAndName) { d in d[VerticalAlignment.center] }
                    }
                    .frame(height: 100)
                }
            }
            .navigationTitle("Settings")
            .scrollContentBackground(.hidden)
            .background(Background())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
