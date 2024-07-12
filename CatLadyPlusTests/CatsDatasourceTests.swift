//
//  CatsDatasourceTests.swift
//  CatLadyPlusTests
//
//  Created by Adelino Faria on 12/07/2024.
//

import XCTest

@testable import CatLadyPlus

final class CatsDatasourceTests: XCTestCase {

    override func setUpWithError() throws {

        UserDefaults.standard.removeObject(forKey: CatsDatasource.Constants.userDefaultsFavouritesKey)
    }

    override func tearDownWithError() throws {

        UserDefaults.standard.removeObject(forKey: CatsDatasource.Constants.userDefaultsFavouritesKey)
    }

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

    func testIsFavourite() async {

        let datasource = CatsDatasource()

        XCTAssertEqual(datasource.isFavourite(catBreedId: "1"), false)

        _ = await datasource.toggleFavourite(catBreedId: "1")

        XCTAssertEqual(datasource.isFavourite(catBreedId: "1"), true)

        _ = await datasource.toggleFavourite(catBreedId: "1")

        XCTAssertEqual(datasource.isFavourite(catBreedId: "1"), false)
    }
}
