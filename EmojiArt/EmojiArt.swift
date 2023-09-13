//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by shiryaev on 12.09.2023.
//

import Foundation

struct EmojiArt {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        let id: Int
    }
    
    private var uniqueEmojiId = 0
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}
