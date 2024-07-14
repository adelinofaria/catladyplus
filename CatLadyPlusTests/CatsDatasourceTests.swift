//
//  CatsDatasourceTests.swift
//  CatLadyPlusTests
//
//  Created by Adelino Faria on 12/07/2024.
//

import XCTest

@testable import CatLadyPlus

final class CatsDatasourceTests: XCTestCase {

    func testRequestBreeds() async throws {

        let datasource = CatsDatasource()

        let models: [CatBreedModel] = try await datasource.requestBreeds()

        XCTAssertEqual(models.count, 10)
    }

    func testRequestBreedsNextPage() async throws {

        let datasource = CatsDatasource()

        let firstModels: [CatBreedModel] = try await datasource.requestBreeds()
        let models: [CatBreedModel] = try await datasource.requestBreedsNextPage()

        XCTAssertEqual(models.count, 10)
        XCTAssertNotEqual(firstModels, models)
    }
}
