//
//  DataRequestableMock.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 23.07.25.
//

@testable import ShareTheMealApp

struct DataRequestableMock: DataRequestable {
    var shouldThrowError: Bool = false
    
    func fetchItems<T: Codable>() throws -> T {
        guard shouldThrowError == false else {
            throw(LocalFileReaderError.fileNotFound)
        }
        return MealPrograms.fake() as! T
    }
}
