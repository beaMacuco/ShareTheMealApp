//
//  DataRequestableMock.swift
//  ShareTheMealAppTests
//
//

@testable import ShareTheMealApp

struct DataRequestableMock: DataRequestable {
    var shouldThrowError: Bool = false
    var mealPrograms: MealPrograms?
    
    func fetchItems<T: Codable>() throws -> T {
        guard shouldThrowError == false else {
            throw(LocalFileReaderError.fileNotFound)
        }
        return mealPrograms as! T
    }
}
