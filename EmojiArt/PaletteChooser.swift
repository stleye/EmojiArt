//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Sebastian Tleye on 15/07/2022.
//

import SwiftUI

struct PaletteChooser: View {
    var emojiFontSize: CGFloat = 40
    var emojiFont: Font { .system(size: emojiFontSize) }

    @EnvironmentObject var store: PaletteStore
    
    @SceneStorage("PaletteChooser.chosenPaletteIndex")
    private var chosePaletteIndex = 0

    var body: some View {
        HStack {
            paletteControlButton
            body(for: store.palette(at: chosePaletteIndex))
        }
        .clipped()
    }
    
    @ViewBuilder
    var contextMenu: some View {
        AnimatedActionButton(title: "Edit", systemImage: "pencil") {
            //editing = true
            paletteToEdit = store.palette(at: chosePaletteIndex)
        }
        AnimatedActionButton(title: "New", systemImage: "plus") {
            store.insertPalette(named: "New", emojis: "", at: chosePaletteIndex)
            //editing = true
            paletteToEdit = store.palette(at: chosePaletteIndex)
        }
        AnimatedActionButton(title: "Delete", systemImage: "minus.circle") {
            chosePaletteIndex = store.removePalette(at: chosePaletteIndex)
        }
        AnimatedActionButton(title: "Manager", systemImage: "slider.vertical.3") {
            managing = true
        }
        gotoMenu
    }
    
    var gotoMenu: some View {
        Menu {
            ForEach (store.palettes) { palette in
                AnimatedActionButton(title: palette.name) {
                    if let index = store.palettes.index(matching: palette) {
                        chosePaletteIndex = index
                    }
                }
            }
        } label: {
            Label("Go To", systemImage: "text.insert")
        }
    }
    
    var paletteControlButton: some View {
        Button {
            withAnimation {
                chosePaletteIndex = (chosePaletteIndex + 1) % store.palettes.count
            }
        } label: {
            Image(systemName: "paintpalette")
        }
        .font(emojiFont)
        .contextMenu {
            contextMenu
        }
    }

    func body(for palette: Palette) -> some View {
        HStack {
            Text(palette.name)
            ScrollingEmojisView(emojis: palette.emojis)
                .font(emojiFont)
        }
        .id(palette.id)
        .transition(rollTransition)
//        .popover(isPresented: $editing) {
//            PaletteEditor(palette: $store.palettes[chosePaletteIndex])
//        }
        .popover(item: $paletteToEdit) { palette in
            PaletteEditor(palette: $store.palettes[palette])
        }
        .sheet(isPresented: $managing) {
            PaletteManager()
        }
    }
    
    //@State private var editing = false
    @State private var paletteToEdit: Palette?
    @State private var managing = false

    var rollTransition: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .offset(x: 0, y: emojiFontSize),
            removal: .offset(x: 0, y: -emojiFontSize)
        )
    }

}

struct ScrollingEmojisView: View {
    
    let emojis: String
 
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.removingDuplicateCharacters.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
    
}

struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser()
    }
}
