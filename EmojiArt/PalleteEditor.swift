//
//  PalleteEditor.swift
//  EmojiArt
//
//  Created by shiryaev on 05.12.2023.
//

import SwiftUI

struct PalleteEditor: View {
    @Binding var chosenPallete: String
    @Binding var isShowing: Bool
    @EnvironmentObject var document: EmojiArtDocument
    
    @State private var palleteName: String = ""
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Pallete Editor")
                    .font(.headline)
                    .padding()
                HStack {
                    Spacer()
                    Button(
                        action: {
                            self.isShowing = false
                        },
                        label: {Text("Done")}
                    ).padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Pallete name", text: $palleteName, onEditingChanged: { began in
                        self.document.renamePalette(self.chosenPallete, to: self.palleteName)
                    })
                    
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                        self.chosenPallete = self.document.addEmoji(self.emojisToAdd, toPalette: self.chosenPallete)
                        self.emojisToAdd = ""
                    })
                }
                Section(header: Text("Remove Emoji")) {
                    MyGrid(chosenPallete.map {String($0)}, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.fontSize))
                            .onTapGesture {
                                self.chosenPallete = self.document.removeEmoji(emoji, fromPalette: self.chosenPallete)
                            }
                    }
                    .frame(height: self.height)
                }
            }
            Spacer()
        }
        .onAppear {
            self.palleteName = self.document.paletteNames[self.chosenPallete] ?? ""
        }
    }
    
    // MARK: - Drawing Constrants
    
    var height: CGFloat {
        CGFloat((chosenPallete.count - 1) / 6) * 70 + 70
    }
    
    var fontSize: CGFloat = 40
}
