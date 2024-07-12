//
//  CatsApiEndpointTests.swift
//  CatLadyPlusTests
//
//  Created by Adelino Faria on 12/07/2024.
//

import XCTest

@testable import CatLadyPlus

final class CatsApiEndpointTests: XCTestCase {

    func testEndpointUrls() throws {

        let cases = [
            CatsApiEndpoint.breeds(limit: 10, page: 1)
        ]

        let expectations = [
            URL(string: "https://api.thecatapi.com/v1/breeds?page=1&limit=10")
        ]

        for index in 0...cases.count - 1 {

            let url = cases[index].url

            if let expectedUrl = expectations[index],
               let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
               let expectedUrlComponents = URLComponents(url: expectedUrl, resolvingAgainstBaseURL: false) {

                XCTAssertEqual(urlComponents.scheme, expectedUrlComponents.scheme)
                XCTAssertEqual(urlComponents.host, expectedUrlComponents.host)
                XCTAssertEqual(urlComponents.path, expectedUrlComponents.path)
                XCTAssertEqual(urlComponents.queryItems?.count, expectedUrlComponents.queryItems?.count)

                if let queryItems = urlComponents.queryItems {

                    for queryItem in queryItems {
                        let contains = expectedUrlComponents.queryItems?.contains(queryItem)

                        XCTAssertTrue(contains ?? false)
                    }
                }
            }
        }
    }

    func testEndpointHeaders() throws {

        let cases = [
            CatsApiEndpoint.breeds(limit: 10, page: 1)
        ]

        let expectations = [
            [
                "Content-Type": "application/json",
                "x-api-key": CatsApiEndpoint.apiKey
            ]
        ]

        for index in 0...cases.count - 1 {

            let headers = cases[index].headers
            let expectedHeaders = expectations[index]

            XCTAssertEqual(headers.count, expectedHeaders.count)

            for header in headers {

                XCTAssertTrue(expectedHeaders[header.key] == header.value)
            }
        }
    }
}
