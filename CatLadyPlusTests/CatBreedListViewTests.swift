//
//  CatBreedListViewTests.swift
//  CatLadyPlusTests
//
//  Created by Adelino Faria on 14/07/2024.
//

import XCTest
import SwiftData

@testable import CatLadyPlus

final class CatBreedListViewTests: XCTestCase {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CatBreedModel.self,
            CatBreedWeightModel.self,
            CatBreedImageModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    func testLocalFilterOfQueryResults() async throws {

        let model1 = CatBreedListViewTests.catBreedModel(id: "id1", name: "name1")
        let model2 = CatBreedListViewTests.catBreedModel(id: "id2", name: "name2", favourite: true)
        let model3 = CatBreedListViewTests.catBreedModel(id: "id3", name: "name3", favourite: false, timestamp: .now - 360)
        let model4 = CatBreedListViewTests.catBreedModel(id: "id4", name: "name4", favourite: true, timestamp: .now - 360)

        let models = [
            model1,
            model2,
            model3,
            model4
        ]

        await MainActor.run {

            models.forEach { self.sharedModelContainer.mainContext.insert($0) }
        }

        let viewModel = CatBreedListView.ViewModel(datasource: CatsDatasource(), favouriteFilter: false)

        XCTAssertEqual(viewModel.locelFilterOfQueryResults(items: []), [])
        XCTAssertEqual(viewModel.locelFilterOfQueryResults(items: models), models)

        viewModel.searchText = "name2"

        XCTAssertEqual(viewModel.locelFilterOfQueryResults(items: models), [model2])

        let viewModel2 = CatBreedListView.ViewModel(datasource: CatsDatasource(), favouriteFilter: true)

        XCTAssertEqual(viewModel2.locelFilterOfQueryResults(items: models), [model2, model4])

        viewModel2.searchText = "name2"

        XCTAssertEqual(viewModel2.locelFilterOfQueryResults(items: models), [model2])
    }

    func testFetchDataset() async throws {

        let viewModel = CatBreedListView.ViewModel(datasource: CatsDatasource(), favouriteFilter: false)

        let models = await viewModel.fetchDataset(limit: 10, page: 0)

        XCTAssertEqual(models?.count, 10)

        let models2 = await viewModel.fetchDataset(limit: 5, page: 1)

        XCTAssertEqual(models2?.count, 5)
    }

    func testMergeExternalDataset() async throws {

        let timestampNow = Date.now

        let model1 = CatBreedListViewTests.catBreedModel(id: "id1", name: "name1", timestamp: .now - 1)
        let model2 = CatBreedListViewTests.catBreedModel(id: "id2", name: "name2", favourite: true, timestamp: .now - 1)
        let model3 = CatBreedListViewTests.catBreedModel(id: "id3", name: "name3", favourite: false, timestamp: .now - 360)
        let eModel1 = CatBreedListViewTests.catBreedModel(id: "id1", name: "name1", favourite: false, timestamp: timestampNow)
        let eModel2 = CatBreedListViewTests.catBreedModel(id: "id2", name: "name2", favourite: false, timestamp: timestampNow)
        let eModel3 = CatBreedListViewTests.catBreedModel(id: "id3", name: "name3", favourite: false, timestamp: timestampNow)

        let models = [
            model1,
            model2,
            model3
        ]

        await MainActor.run {

            models.forEach { self.sharedModelContainer.mainContext.insert($0) }
        }

        let viewModel = CatBreedListView.ViewModel(datasource: CatsDatasource(), favouriteFilter: false)

        viewModel.mergeExternalDataset(localDataset: models, externalDataset: [eModel1, eModel2, eModel3])

        XCTAssertEqual(eModel1.id, model1.id)
        XCTAssertEqual(eModel1.name, model1.name)
        XCTAssertEqual(eModel1.favourite, model1.favourite)
        XCTAssertNotEqual(eModel1.timestamp, model1.timestamp)
        XCTAssertEqual(eModel2.id, model2.id)
        XCTAssertEqual(eModel2.name, model2.name)
        XCTAssertEqual(eModel2.favourite, model2.favourite)
        XCTAssertNotEqual(eModel2.timestamp, model2.timestamp)
        XCTAssertEqual(eModel3.id, model3.id)
        XCTAssertEqual(eModel3.name, model3.name)
        XCTAssertEqual(eModel3.favourite, model3.favourite)
        XCTAssertNotEqual(eModel3.timestamp, model3.timestamp)
    }
}

extension CatBreedListViewTests {

    static func catBreedModel(id: String, name: String, favourite: Bool = false, timestamp: Date = .now) -> CatBreedModel {

        return CatBreedModel(
            weight: CatBreedWeightModel(imperial: nil, metric: nil),
            id: id,
            name: name,
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
            favourite: favourite,
            timestamp: timestamp)
    }
}
