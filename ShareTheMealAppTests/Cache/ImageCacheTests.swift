//
//  ImageCacheTests.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 29.07.25.
//

import XCTest
@testable import ShareTheMealApp

class ImageCacheTests: XCTestCase {
    var sut: ImageCache!
    var cache: NSCache<NSString, UIImage>!
    
    override func setUp() {
        super.setUp()
        cache = NSCache<NSString, UIImage>()
        sut = ImageCache(cache: cache)
    }
    
    func test_ImageCacheRetrieveImageFromCache() {
        let reference = "1234"
        let expected = UIImage()
        cache.setObject(expected, forKey: (reference as NSString))
        
        let fetchedImage = sut.fetch(reference: reference)
        
        XCTAssertEqual(fetchedImage, expected)
    }
    
    func test_ImageCachePersistsImageToCache() {
        let reference = "1234"
        let expected = UIImage()
        
        sut.persist(image: expected, by: reference)
        let cached = cache.object(forKey: (reference as NSString))
        
        XCTAssertEqual(cached, expected)
    }
}
