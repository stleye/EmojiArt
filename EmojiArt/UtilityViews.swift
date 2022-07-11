//
//  UtilityViews.swift
//  EmojiArt
//
//  Created by Sebastian Tleye on 10/07/2022.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?

    var body: some View {
        if uiImage != nil {
            Image(uiImage: uiImage!)
                .resizable()
                .scaledToFit()
        }
    }

}
