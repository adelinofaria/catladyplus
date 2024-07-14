//
//  CatBreedModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation
import SwiftData

@Model
final class CatBreedModel: Decodable {

    private enum CodingKeys : String, CodingKey {
        case weight
        case id
        case name
        case cfa_url
        case vetstreet_url
        case vcahospitals_url
        case temperament
        case origin
        case country_codes
        case country_code
        case modelDescription = "description"
        case life_span
        case indoor
        case lap
        case alt_names
        case adaptability
        case affection_level
        case child_friendly
        case dog_friendly
        case energy_level
        case grooming
        case health_issues
        case intelligence
        case shedding_level
        case social_needs
        case stranger_friendly
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressed_tail
        case short_legs
        case wikipedia_url
        case hypoallergenic
        case reference_image_id
        case image
    }

    private(set) var weight: CatBreedWeightModel?
    @Attribute(.unique) let id: String
    let name: String
    let cfa_url: String?
    let vetstreet_url: String?
    let vcahospitals_url: String?
    let temperament: String?
    let origin: String?
    let country_codes: String?
    let country_code: String?
    let modelDescription: String?
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
    private(set) var image: CatBreedImageModel?

    var favourite: Bool?
    var timestamp: Date

    init(from decoder: any Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weight = try container.decodeIfPresent(CatBreedWeightModel.self, forKey: .weight)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.cfa_url = try container.decodeIfPresent(String.self, forKey: .cfa_url)
        self.vetstreet_url = try container.decodeIfPresent(String.self, forKey: .vetstreet_url)
        self.vcahospitals_url = try container.decodeIfPresent(String.self, forKey: .vcahospitals_url)
        self.temperament = try container.decodeIfPresent(String.self, forKey: .temperament)
        self.origin = try container.decodeIfPresent(String.self, forKey: .origin)
        self.country_codes = try container.decodeIfPresent(String.self, forKey: .country_codes)
        self.country_code = try container.decodeIfPresent(String.self, forKey: .country_code)
        self.modelDescription = try container.decodeIfPresent(String.self, forKey: .modelDescription)
        self.life_span = try container.decodeIfPresent(String.self, forKey: .life_span)
        self.indoor = try container.decodeIfPresent(Int.self, forKey: .indoor)
        self.lap = try container.decodeIfPresent(Int.self, forKey: .lap)
        self.alt_names = try container.decodeIfPresent(String.self, forKey: .alt_names)
        self.adaptability = try container.decodeIfPresent(Int.self, forKey: .adaptability)
        self.affection_level = try container.decodeIfPresent(Int.self, forKey: .affection_level)
        self.child_friendly = try container.decodeIfPresent(Int.self, forKey: .child_friendly)
        self.dog_friendly = try container.decodeIfPresent(Int.self, forKey: .dog_friendly)
        self.energy_level = try container.decodeIfPresent(Int.self, forKey: .energy_level)
        self.grooming = try container.decodeIfPresent(Int.self, forKey: .grooming)
        self.health_issues = try container.decodeIfPresent(Int.self, forKey: .health_issues)
        self.intelligence = try container.decodeIfPresent(Int.self, forKey: .intelligence)
        self.shedding_level = try container.decodeIfPresent(Int.self, forKey: .shedding_level)
        self.social_needs = try container.decodeIfPresent(Int.self, forKey: .social_needs)
        self.stranger_friendly = try container.decodeIfPresent(Int.self, forKey: .stranger_friendly)
        self.vocalisation = try container.decodeIfPresent(Int.self, forKey: .vocalisation)
        self.experimental = try container.decodeIfPresent(Int.self, forKey: .experimental)
        self.hairless = try container.decodeIfPresent(Int.self, forKey: .hairless)
        self.natural = try container.decodeIfPresent(Int.self, forKey: .natural)
        self.rare = try container.decodeIfPresent(Int.self, forKey: .rare)
        self.rex = try container.decodeIfPresent(Int.self, forKey: .rex)
        self.suppressed_tail = try container.decodeIfPresent(Int.self, forKey: .suppressed_tail)
        self.short_legs = try container.decodeIfPresent(Int.self, forKey: .short_legs)
        self.wikipedia_url = try container.decodeIfPresent(String.self, forKey: .wikipedia_url)
        self.hypoallergenic = try container.decodeIfPresent(Int.self, forKey: .hypoallergenic)
        self.reference_image_id = try container.decodeIfPresent(String.self, forKey: .reference_image_id)
        self.image = try container.decodeIfPresent(CatBreedImageModel.self, forKey: .image)
        self.favourite = nil
        self.timestamp = .now
    }

    init(weight: CatBreedWeightModel?,
         id: String,
         name: String,
         cfa_url: String?,
         vetstreet_url: String?,
         vcahospitals_url: String?,
         temperament: String?,
         origin: String?,
         country_codes: String?,
         country_code: String?,
         modelDescription: String?,
         life_span: String?,
         indoor: Int?,
         lap: Int?,
         alt_names: String?,
         adaptability: Int?,
         affection_level: Int?,
         child_friendly: Int?,
         dog_friendly: Int?,
         energy_level: Int?,
         grooming: Int?,
         health_issues: Int?,
         intelligence: Int?,
         shedding_level: Int?,
         social_needs: Int?,
         stranger_friendly: Int?,
         vocalisation: Int?,
         experimental: Int?,
         hairless: Int?,
         natural: Int?,
         rare: Int?,
         rex: Int?,
         suppressed_tail: Int?,
         short_legs: Int?,
         wikipedia_url: String?,
         hypoallergenic: Int?,
         reference_image_id: String?,
         image: CatBreedImageModel?,
         favourite: Bool?,
         timestamp: Date) {

        self.weight = weight
        self.id = id
        self.name = name
        self.cfa_url = cfa_url
        self.vetstreet_url = vetstreet_url
        self.vcahospitals_url = vcahospitals_url
        self.temperament = temperament
        self.origin = origin
        self.country_codes = country_codes
        self.country_code = country_code
        self.modelDescription = modelDescription
        self.life_span = life_span
        self.indoor = indoor
        self.lap = lap
        self.alt_names = alt_names
        self.adaptability = adaptability
        self.affection_level = affection_level
        self.child_friendly = child_friendly
        self.dog_friendly = dog_friendly
        self.energy_level = energy_level
        self.grooming = grooming
        self.health_issues = health_issues
        self.intelligence = intelligence
        self.shedding_level = shedding_level
        self.social_needs = social_needs
        self.stranger_friendly = stranger_friendly
        self.vocalisation = vocalisation
        self.experimental = experimental
        self.hairless = hairless
        self.natural = natural
        self.rare = rare
        self.rex = rex
        self.suppressed_tail = suppressed_tail
        self.short_legs = short_legs
        self.wikipedia_url = wikipedia_url
        self.hypoallergenic = hypoallergenic
        self.reference_image_id = reference_image_id
        self.image = image
        self.favourite = favourite
        self.timestamp = timestamp
    }
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
        modelDescription: nil,
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
        image: nil,
        favourite: false,
        timestamp: .now)
}
