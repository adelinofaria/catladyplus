//
//  CatBreedWeightModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 14/07/2024.
//

import Foundation
import SwiftData

@Model
final class CatBreedWeightModel: Decodable {

    private enum CodingKeys : String, CodingKey {
        case imperial, metric
    }

    let imperial: String?
    let metric: String?

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imperial = try container.decodeIfPresent(String.self, forKey: .imperial)
        self.metric = try container.decodeIfPresent(String.self, forKey: .metric)
    }

    init(imperial: String?, metric: String?) {
        self.imperial = imperial
        self.metric = metric
    }
}
