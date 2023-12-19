//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by shiryaev on 24.10.2023.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?

    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
