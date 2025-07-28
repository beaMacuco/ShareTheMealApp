//
//  MealProgramsViewModel.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 22.07.25.
//

import SwiftUI
import Combine

final class MealProgramsViewModel: ObservableObject {
    private let viewOffSet = 3
    let mealProgramRequest: MealProgramRequest
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published private(set) var visibleMealPrograms: [MealProgram] = []
    @Published private(set) var filteredMealPrograms: [MealProgram] = []
    @Published var shouldSearchMeals: Bool = false
    
    init(mealProgramRequest: MealProgramRequest = MealProgramRequest()) {
        self.mealProgramRequest = mealProgramRequest
        addObservers()
    }
    
    @MainActor
    func loadInitialData() {
        Task {
            do {
                try await mealProgramRequest.loadMealPrograms()
                visibleMealPrograms = mealProgramRequest.fetchMoreItems()
                filteredMealPrograms = visibleMealPrograms
            } catch {
                // show or handle error in user friendly way
            }
        }
    }
    
    private func addObservers() {
        $searchText
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else {
                    return
                }
                self.applySearchFilter()
            }
            .store(in: &cancellables)
    }
    
    private func applySearchFilter() {
        if searchText.isEmpty {
            filteredMealPrograms = visibleMealPrograms
        } else {
            filteredMealPrograms = mealProgramRequest.searchItems(query: searchText)
        }
    }
    
    func fetchMoreIfNeeded(currentItem: MealProgram) {
        guard shouldFetchMore(currentItem: currentItem) else {
            return
        }
        let newItems = mealProgramRequest.fetchMoreItems()
        visibleMealPrograms.append(contentsOf:  newItems)
    }
    
    private func shouldFetchMore(currentItem: MealProgram?) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        let thresholdIndex = visibleMealPrograms.index(visibleMealPrograms.endIndex, offsetBy: -viewOffSet)
        guard visibleMealPrograms.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex else {
            return false
        }
        return true
    }
}
