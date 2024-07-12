//
//  CatBreedModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

struct CatBreedModel: Decodable, Hashable {

    let weight: CatBreedWeightModel?
    let id: String
    let name: String
    let cfa_url: String?
    let vetstreet_url: String?
    let vcahospitals_url: String?
    let temperament: String?
    let origin: String?
    let country_codes: String?
    let country_code: String?
    let description: String?
    let life_span: String?
    let indoor: Int?
    let lap: Int?
    let alt_names: String?
    let adaptability: Int?
    let affection_level: Int?
    let child_friendly: Int?
    let dog_friendly: Int?
    let energy_level: Int?
    let grooming: Int?
    let health_issues: Int?
    let intelligence: Int?
    let shedding_level: Int?
    let social_needs: Int?
    let stranger_friendly: Int?
    let vocalisation: Int?
    let experimental: Int?
    let hairless: Int?
    let natural: Int?
    let rare: Int?
    let rex: Int?
    let suppressed_tail: Int?
    let short_legs: Int?
    let wikipedia_url: String?
    let hypoallergenic: Int?
    let reference_image_id: String?
    let image: CatBreedImageModel?

    // MARK: Equatable

    static func == (lhs: CatBreedModel, rhs: CatBreedModel) -> Bool {
        return lhs.id == rhs.id
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CatBreedWeightModel: Decodable {
    let imperial: String?
    let metric: String?
}

struct CatBreedImageModel: Decodable {
    let id: String
    let width: Int
    let height: Int
    let url: URL
}


extension CatBreedModel {
    static let stub = CatBreedModel(
        weight: CatBreedWeightModel(imperial: nil, metric: nil),
        id: "nil",
        name: "nil",
        cfa_url: nil,
        vetstreet_url: nil,
        vcahospitals_url: nil,
        temperament: nil,
        origin: nil,
        country_codes: nil,
        country_code: nil,
        description: nil,
        life_span: nil,
        indoor: nil,
        lap: nil,
        alt_names: nil,
        adaptability: nil,
        affection_level: nil,
        child_friendly: nil,
        dog_friendly: nil,
        energy_level: nil,
        grooming: nil,
        health_issues: nil,
        intelligence: nil,
        shedding_level: nil,
        social_needs: nil,
        stranger_friendly: nil,
        vocalisation: nil,
        experimental: nil,
        hairless: nil,
        natural: nil,
        rare: nil,
        rex: nil,
        suppressed_tail: nil,
        short_legs: nil,
        wikipedia_url: nil,
        hypoallergenic: nil,
        reference_image_id: nil,
        image: nil)
}
