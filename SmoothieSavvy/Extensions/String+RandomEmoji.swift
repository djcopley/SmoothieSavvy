//
//  String+RandomEmoji.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 4/8/23.
//

import Foundation

extension String {
    static var randomEmoji: String {
        IngredientEmojiProvider.allEmojis.randomElement()!.value
    }
}
