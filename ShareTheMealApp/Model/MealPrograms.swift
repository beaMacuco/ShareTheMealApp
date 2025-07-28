//
//  MealPrograms.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 23.07.25.
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
