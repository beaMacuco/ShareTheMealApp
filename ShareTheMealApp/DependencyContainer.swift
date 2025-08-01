//
//  DependencyContainer.swift
//  ShareTheMealApp
//
//

import Foundation

@MainActor
class DependencyContainer {
    static let uiTestMode = "USE_MOCK"
    static let shared = DependencyContainer()

    var mealProgramsViewModel: MealProgramsViewModel {
        if ProcessInfo.processInfo.environment[Self.uiTestMode] == "true" {
            return MealProgramsViewModel()
        } else {
            return MealProgramsViewModel()
        }
    }
}
