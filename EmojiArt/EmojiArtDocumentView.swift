//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by shiryaev on 12.09.2023.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map{String($0)}, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                    }
                }
            }
            .padding(.horizontal)
            Rectangle().foregroundColor(.yellow)
                .onDrop(of: ["public.image"], isTargeted: nil) {
                    
                }
        }
    }
    private let defaultEmojiSize: CGFloat = 40
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
