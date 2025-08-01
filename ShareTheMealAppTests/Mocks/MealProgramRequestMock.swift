//
//  MealProgramRequestMock.swift
//  ShareTheMealAppTests
//
//

import Foundation

class MealProgramRequestMock: MealProgramRequestable {
    var mealPrograms: [MealProgram] = []
    var isLoaded: Bool = false
    var throwError: Bool = false
    
    func loadMealPrograms() async throws {
        if throwError {
            throw NetworkError.decodingError
        } else {
            isLoaded = true
        }
    }
    
    func searchItems(query: String) -> [MealProgram] {
        mealPrograms
    }
    
    func fetchPage(offset: Int) -> [MealProgram] {
        mealPrograms
    }
}
