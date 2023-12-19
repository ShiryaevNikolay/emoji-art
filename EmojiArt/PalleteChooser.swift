//
//  PalleteChooser.swift
//  EmojiArt
//
//  Created by shiryaev on 05.12.2023.
//

import SwiftUI

struct PalleteChooser: View {
    @ObservedObject var document: EmojiArtDocument
    @Binding var chosenPallete: String
    @State private var showPalleteEditor = false

    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPallete = self.document.palette(after: self.chosenPallete)
            }, onDecrement: {
                self.chosenPallete = self.document.palette(before: self.chosenPallete)
            }, label: {EmptyView()})
            Text(self.document.paletteNames[self.chosenPallete] ?? "")
            Image(systemName: "keyboard")
                .onTapGesture {
                    self.showPalleteEditor = true
                }
                .imageScale(.large)
                .popover(isPresented: self.$showPalleteEditor) {
                    PalleteEditor(chosenPallete: $chosenPallete)
                        .environmentObject(self.document)
                        .frame(minWidth: 300, minHeight: 500)
                }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PallteteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PalleteChooser(document: EmojiArtDocument(), chosenPallete: Binding.constant(""))
    }
}
