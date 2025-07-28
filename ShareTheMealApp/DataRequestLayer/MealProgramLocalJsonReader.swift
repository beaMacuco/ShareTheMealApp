//
//  MealProgramLocalJsonReader.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 24.07.25.
//

import Foundation

protocol MealProgramLocalJsonReadable {
    func loadPrograms() throws
    func filterPrograms(query: String) -> [MealProgram]
    func fetchCurrentPage(offset: Int, end: Int) -> [MealProgram]
}

final class MealProgramLocalJsonReader: MealProgramLocalJsonReadable {
    private let dataRequestable: DataRequestable
    private(set) var mealPrograms: [MealProgram] = []
    
    init(dataRequestable: DataRequestable = LocalJsonReader()) {
        self.dataRequestable = dataRequestable
    }
    
    func loadPrograms() throws {
        mealPrograms = try fetchItems()
    }
    
    func filterPrograms(query: String) -> [MealProgram] {
        let lowercaseQuery = query.lowercased()
        return mealPrograms.filter {
            $0.name.lowercased().contains(lowercaseQuery) ||
            $0.country.lowercased().contains(lowercaseQuery)
        }
    }
    
    func fetchCurrentPage(offset: Int, end: Int) -> [MealProgram] {
        Array(mealPrograms[offset..<end])
    }
    
    private func fetchItems() throws -> [MealProgram] {
        let items: MealPrograms = try dataRequestable.fetchItems()
        return items.programs
    }
}
