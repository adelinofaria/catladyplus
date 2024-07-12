//
//  CatBreedModelTests.swift
//  CatLadyPlusTests
//
//  Created by Adelino Faria on 12/07/2024.
//

import XCTest

@testable import CatLadyPlus

final class CatBreedModelTests: XCTestCase {

    func testInitMinimumFields() throws {

        let dictionary = [
            "id": "123",
            "name": "cat name"
        ]

        let data = try JSONSerialization.data(withJSONObject: dictionary)

        let model = try JSONDecoder().decode(CatBreedModel.self, from: data)

        XCTAssertEqual(model.id, dictionary["id"])
        XCTAssertEqual(model.name, dictionary["name"])
    }

    func testInit() throws {

        let dictionary: [String: Any] = [
            "weight": [
                "imperial": "imperial value",
                "metric": "metric value"
            ],
            "id": "123",
            "name": "cat name",
            "cfa_url": "cfa_url value",
            "vetstreet_url": "vetstreet_url value",
            "vcahospitals_url": "vcahospitals_url value",
            "temperament": "temperament value",
            "origin": "origin value",
            "country_codes": "country_codes value",
            "country_code": "country_code value",
            "description": "description value",
            "life_span": "life_span value",
            "indoor": 127,
            "lap": 128,
            "alt_names": "alt_names value",
            "adaptability": 129,
            "affection_level": 130,
            "child_friendly": 131,
            "dog_friendly": 132,
            "energy_level": 133,
            "grooming": 134,
            "health_issues": 135,
            "intelligence": 136,
            "shedding_level": 137,
            "social_needs": 138,
            "stranger_friendly": 139,
            "vocalisation": 140,
            "experimental": 141,
            "hairless": 142,
            "natural": 143,
            "rare": 144,
            "rex": 145,
            "suppressed_tail": 146,
            "short_legs": 147,
            "wikipedia_url": "wikipedia_url value",
            "hypoallergenic": 148,
            "reference_image_id": "reference_image_id value",
            "image": [
                "id": "image id",
                "width": 112,
                "height": 113,
                "url": "https://domain.com/path"
            ]
        ]

        let data = try JSONSerialization.data(withJSONObject: dictionary)

        let model = try JSONDecoder().decode(CatBreedModel.self, from: data)

        XCTAssertEqual(model.weight?.imperial, (dictionary["weight"] as? [String: Any])?["imperial"] as? String)
        XCTAssertEqual(model.weight?.metric, (dictionary["weight"] as? [String: Any])?["metric"] as? String)

        XCTAssertEqual(model.id, dictionary["id"] as? String)
        XCTAssertEqual(model.name, dictionary["name"] as? String)
        XCTAssertEqual(model.cfa_url, dictionary["cfa_url"] as? String)
        XCTAssertEqual(model.vetstreet_url, dictionary["vetstreet_url"] as? String)
        XCTAssertEqual(model.vcahospitals_url, dictionary["vcahospitals_url"] as? String)
        XCTAssertEqual(model.temperament, dictionary["temperament"] as? String)
        XCTAssertEqual(model.origin, dictionary["origin"] as? String)
        XCTAssertEqual(model.country_codes, dictionary["country_codes"] as? String)
        XCTAssertEqual(model.country_code, dictionary["country_code"] as? String)
        XCTAssertEqual(model.description, dictionary["description"] as? String)
        XCTAssertEqual(model.life_span, dictionary["life_span"] as? String)
        XCTAssertEqual(model.indoor, dictionary["indoor"] as? Int)
        XCTAssertEqual(model.lap, dictionary["lap"] as? Int)
        XCTAssertEqual(model.alt_names, dictionary["alt_names"] as? String)
        XCTAssertEqual(model.adaptability, dictionary["adaptability"] as? Int)
        XCTAssertEqual(model.affection_level, dictionary["affection_level"] as? Int)
        XCTAssertEqual(model.child_friendly, dictionary["child_friendly"] as? Int)
        XCTAssertEqual(model.dog_friendly, dictionary["dog_friendly"] as? Int)
        XCTAssertEqual(model.energy_level, dictionary["energy_level"] as? Int)
        XCTAssertEqual(model.grooming, dictionary["grooming"] as? Int)
        XCTAssertEqual(model.health_issues, dictionary["health_issues"] as? Int)
        XCTAssertEqual(model.intelligence, dictionary["intelligence"] as? Int)
        XCTAssertEqual(model.shedding_level, dictionary["shedding_level"] as? Int)
        XCTAssertEqual(model.social_needs, dictionary["social_needs"] as? Int)
        XCTAssertEqual(model.stranger_friendly, dictionary["stranger_friendly"] as? Int)
        XCTAssertEqual(model.vocalisation, dictionary["vocalisation"] as? Int)
        XCTAssertEqual(model.experimental, dictionary["experimental"] as? Int)
        XCTAssertEqual(model.hairless, dictionary["hairless"] as? Int)
        XCTAssertEqual(model.natural, dictionary["natural"] as? Int)
        XCTAssertEqual(model.rare, dictionary["rare"] as? Int)
        XCTAssertEqual(model.rex, dictionary["rex"] as? Int)
        XCTAssertEqual(model.suppressed_tail, dictionary["suppressed_tail"] as? Int)
        XCTAssertEqual(model.short_legs, dictionary["short_legs"] as? Int)
        XCTAssertEqual(model.wikipedia_url, dictionary["wikipedia_url"] as? String)
        XCTAssertEqual(model.hypoallergenic, dictionary["hypoallergenic"] as? Int)
        XCTAssertEqual(model.reference_image_id, dictionary["reference_image_id"] as? String)


        XCTAssertEqual(model.image?.id, (dictionary["image"] as? [String: Any])?["id"] as? String)
        XCTAssertEqual(model.image?.width, (dictionary["image"] as? [String: Any])?["width"] as? Int)
        XCTAssertEqual(model.image?.height, (dictionary["image"] as? [String: Any])?["height"] as? Int)
        XCTAssertEqual(model.image?.url.absoluteString, (dictionary["image"] as? [String: Any])?["url"] as? String)
    }
}
