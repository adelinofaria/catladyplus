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

        let models: [CatBreedModel] = try await datasource.requestBreeds(limit: 10, page: 0)

        XCTAssertEqual(models.count, 10)

        let models2: [CatBreedModel] = try await datasource.requestBreeds(limit: 5, page: 1)

        XCTAssertEqual(models2.count, 5)
    }
}
