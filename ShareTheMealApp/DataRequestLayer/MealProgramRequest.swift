//
//  Untitled.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 22.07.25.
//

protocol MealProgramRequestable {
    func loadMealPrograms() async throws
    func searchItems(query: String) -> [MealProgram]
    func fetchPage(offset: Int) -> [MealProgram]
}

final class MealProgramRequest: MealProgramRequestable {
    private let pageSize = 4
    private let mealProgramLocalJsonReader: MealProgramLocalJsonReader
    
    init(mealProgramLocalJsonReader: MealProgramLocalJsonReader = MealProgramLocalJsonReader()) {
        self.mealProgramLocalJsonReader = mealProgramLocalJsonReader
    }
    
    func loadMealPrograms() async throws {
        try mealProgramLocalJsonReader.loadPrograms()
    }
    
    func searchItems(query: String) -> [MealProgram] {
        guard !query.isEmpty else {
            return []
        }
        return mealProgramLocalJsonReader.filterPrograms(query: query)
    }
    
    func fetchPage(offset: Int) -> [MealProgram] {
        let end = min(offset + pageSize, mealProgramLocalJsonReader.mealPrograms.count)
        guard offset < end else {
            return []
        }
        return mealProgramLocalJsonReader.fetchCurrentPage(offset: offset, end: end)
    }
}

