//
//  Collection+EnumeratedArray.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import Foundation

extension Collection {
    func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
        Array(self.enumerated())
    }
}
