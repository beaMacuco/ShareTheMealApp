//
//  ImageRequestTests.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 30.07.25.
//

import XCTest
@testable import ShareTheMealApp

final class ImageRequestTests: XCTestCase {
    private var sut: ImageRequest!
    private let testUrl = "www.test.com"
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
        sut = ImageRequest(urlSession: urlSession)
    }
    
    func test_GivenANetworkRequest_WhenURLisMalformed_ThenMalformedErrorIsThrown() async {
        let malformed = ""
        
        do {
            _ = try await sut.fetchImage(urlString: malformed)
            XCTFail("Should have thrown malformed url error")
        } catch {
            XCTAssertEqual((error as? NetworkError), NetworkError.malformedUrl)
        }
    }
    
    func test_GivenANetworkRequest_WhenTheResponseIsInvalid_ThenInvalidResponseErrorIsThrown() async {
        guard let url = URL(string: testUrl) else {
            XCTFail("URL is nil")
            return
        }
        
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        URLProtocolMock.requestHandler = { request in
            (response, Data())
        }
        
        do {
            _ = try await sut.fetchImage(urlString: testUrl)
            XCTFail("Should have thrown invalid response error")
        } catch {
            XCTAssertEqual((error as? NetworkError), NetworkError.invalidResponse)
        }
    }
    
    func test_GivenANetworkRequest_WhenTheResponseContainsHttpErrors_ThenHttpResponseErrorIsThrown() async {
        let statusCode = 400
        guard let url = URL(string: testUrl), let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil) else {
            XCTFail("HTTPURLResponse or URL is nil")
            return
        }
        
        URLProtocolMock.requestHandler = { request in
            (response, Data())
        }
        
        do {
            _ = try await sut.fetchImage(urlString: testUrl)
            XCTFail("Should have thrown http response error")
        } catch {
            XCTAssertEqual((error as? NetworkError), NetworkError.httpResponseError(statusCode))
        }
    }
    
    func test_GivenANetworkRequest_WhenTheResponseContainsNoErrors_ThenDataIsReturned() async {
        guard let url = URL(string: testUrl), let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("HTTPURLResponse or URL is nil")
            return
        }
        
        URLProtocolMock.requestHandler = { request in
            (response, Data())
        }
        
        do {
            let data = try await sut.fetchImage(urlString: testUrl)
            XCTAssertNotNil(data)
            
        } catch {
            XCTFail("Should have returned data as a response")
        }
    }
}
