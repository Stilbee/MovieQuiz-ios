//
//  MoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by Alibi on 19.07.2024.
//

import Foundation
import XCTest

@testable import MovieQuiz

class MoviesLoaderTests: XCTestCase {
    func testSuccessLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(emulateError: false) // говорим, что не хотим эмулировать ошибку
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            // Then
            switch result {
            case .success(let movies):
                // давайте проверим, что пришло, например, два фильма — ведь в тестовых данных их всего два
                XCTAssertEqual(movies.items.count, 2)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFailureLoading() throws {
        //Given
        let stubNetworkClient = StubNetworkClient(emulateError: true)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        //When
        let expectation = expectation(description: "loading expectation")
        
        loader.loadMovies { result in
            
            //Then
            switch result {
            case.failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            case.success(_):
                XCTFail("unexpected failure")
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    struct StubNetworkClient: NetworkRouting {
        
        enum TestError: Error { // тестовая ошибка
            case test
        }
        
        let emulateError: Bool // этот параметр нужен, чтобы заглушка эмулировала либо ошибку сети, либо успешный ответ
        
        func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
            if emulateError {
                handler(.failure(TestError.test))
            } else {
                handler(.success(expectedResponse))
            }
        }
        
        private var expectedResponse: Data {
        """
        {
           "errorMessage" : "",
           "items": [
                {
                    "id": "tt0111161",
                    "rank": "1",
                    "title": "The Shawshank Redemption",
                    "fullTitle": "The Shawshank Redemption (1994)",
                    "year": "1994",
                    "image": "https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_.jpg",
                    "crew": "",
                    "imDbRating": "9.3",
                    "imDbRatingCount": "2913329"
                },
                {
                    "id": "tt0068646",
                    "rank": "2",
                    "title": "The Godfather",
                    "fullTitle": "The Godfather (1972)",
                    "year": "1972",
                    "image": "https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg",
                    "crew": "",
                    "imDbRating": "9.2",
                    "imDbRatingCount": "2030152"
                }
            ]
          }
        """.data(using: .utf8) ?? Data()
        }
    }
}
