//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Sebastian Tleye on 10/07/2022.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
