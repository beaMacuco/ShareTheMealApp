//
//  LocalJsonReaderMock.swift
//  ShareTheMealAppTests
//
//

import Foundation

class LocalJsonReaderMock: MealProgramLocalJsonReadable {
    var programs: [MealProgram] = []
    var isLoaded: Bool = false
    var programCount: Int = 0
    
    func loadPrograms() throws {
        isLoaded = true
    }
    
    func filterPrograms(query: String) -> [MealProgram] {
        programs
    }
    
    func fetchCurrentPage(offset: Int, end: Int) -> [MealProgram] {
        programs
    }
    
    func countPrograms() -> Int {
        programCount
    }
}
