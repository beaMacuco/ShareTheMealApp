//
//  MealPrograms.swift
//  ShareTheMealApp
//
//

import Foundation

struct MealPrograms: Codable {
    let programs: [MealProgram]
}

extension MealPrograms {
    static func fake() -> MealPrograms {
        MealPrograms(programs: [MealProgram.fake(), MealProgram.fake(), MealProgram.fake()])
    }
}
