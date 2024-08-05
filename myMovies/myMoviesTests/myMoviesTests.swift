//
//  myMoviesTests.swift
//  myMoviesTests
//
//

import XCTest
@testable import myMovies

final class myMoviesTests: XCTestCase {

    override func setUpWithError() throws {
        // Registering the Sample URL protocol before running tests
        URLProtocol.registerClass(SampleURLProtocol.self)
    }

    override func tearDownWithError() throws {
        // Unregister the Sample URL protocol after tests
        URLProtocol.unregisterClass(SampleURLProtocol.self)
    }

    // function to checking API request handling
    func testFetchMovieDetailsWithSample() throws {
        let expectation = XCTestExpectation(description: "Fetch movie details using sample API")

        // Useing the sample API URL for "Chennai Express"
        let url = URL(string: "https://www.omdbapi.com/?apikey=9e96a71f&t=Chennai%20Express&y=2013")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handling errors
            if let error = error {
                XCTFail("Failed to fetch data: \(error)")
                return
            }

         
            guard let data = data else {
                XCTFail("No data received")
                return
            }

            do {
                // Parsing the JSON response
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Verifying the content of the sample response
                    XCTAssertEqual(jsonResponse["Title"] as? String, "Chennai Express")
                    XCTAssertEqual(jsonResponse["Year"] as? String, "2013")
                    XCTAssertEqual(jsonResponse["Director"] as? String, "Rohit Shetty")
                    XCTAssertEqual(jsonResponse["Actors"] as? String, "Shah Rukh Khan, Deepika Padukone")
                    XCTAssertEqual(jsonResponse["Genre"] as? String, "Action, Comedy, Drama")
                    XCTAssertEqual(jsonResponse["Language"] as? String, "Hindi")
                    XCTAssertEqual(jsonResponse["imdbRating"] as? String, "5.6")
                    XCTAssertEqual(jsonResponse["Poster"] as? String, "https://example.com/chennai-express-poster.jpg")
                    XCTAssertEqual(jsonResponse["imdbVotes"] as? String, "12345")
                    
                  
                    expectation.fulfill()
                }
            } catch {
                XCTFail("Error parsing JSON: \(error)")
            }
        }

        // Starting the data task
        task.resume()
       
        wait(for: [expectation], timeout: 10.0)
    }
}

