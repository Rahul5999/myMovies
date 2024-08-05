//
//  SampleURLProtocol.swift
//  myMoviesTests
//
//

import Foundation


//A sample PRotocol to simulate API Responses
class SampleURLProtocol: URLProtocol {

    // Checking if the request can be handled by this protocol
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

  
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // Sample response data for "Chennai Express"
        let jsonResponse = [
            "Title": "Chennai Express",
            "Year": "2013",
            "Director": "Rohit Shetty",
            "Actors": "Shah Rukh Khan, Deepika Padukone",
            "Genre": "Action, Comedy, Drama",
            "Language": "Hindi",
            "imdbRating": "5.6",
            "Poster": "https://example.com/chennai-express-poster.jpg",
            "imdbVotes": "12345"
        ]
        
       
        guard let data = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
            return
        }

       
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        // Send the response and data to the client
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocol(self, didLoad: data)
        self.client?.urlProtocolDidFinishLoading(self)
    }

   
    override func stopLoading() {}
}

