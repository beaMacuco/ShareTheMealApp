//
//  ImageCacheMock.swift
//  ShareTheMealAppTests
//
//

import SwiftUI

class ImageLoadingMock: ImageLoading {
    var shouldFail: Bool = false
    
    func fetchImage(from reference: String) async -> Image? {
        shouldFail ? nil : Image("test")
    }
}
