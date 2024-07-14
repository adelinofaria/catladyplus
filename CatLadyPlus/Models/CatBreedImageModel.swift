//
//  CatBreedImageModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 14/07/2024.
//

import Foundation
import SwiftData

@Model
final class CatBreedImageModel: Decodable {

    private enum CodingKeys : String, CodingKey {
        case id, width, height, url
    }

    let id: String
    let width: Int
    let height: Int
    let url: URL

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.url = try container.decode(URL.self, forKey: .url)
    }

    init(id: String, width: Int, height: Int, url: URL) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
    }
}
