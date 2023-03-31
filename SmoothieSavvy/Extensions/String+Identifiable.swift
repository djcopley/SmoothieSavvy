//
//  String+Identifiable.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/29/23.
//

import Foundation

extension String: Identifiable {
    public var id: UUID {
        UUID()
    }
}
