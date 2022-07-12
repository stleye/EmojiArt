//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Sebastian Tleye on 10/07/2022.
//

import Foundation

extension EmojiArtModel {

    enum Background: Equatable, Codable {
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
            switch self {
            case .url(let uRL): return uRL
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }

    }

}
