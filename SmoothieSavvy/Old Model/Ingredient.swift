//
//  Ingredient.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import Foundation
import SwiftUI

struct Ingredient: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
}
