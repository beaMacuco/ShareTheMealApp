//
//  MealProgramsViewModel.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 22.07.25.
//

import SwiftUI
import Combine

/// Keeps track of the view state to be displayed in the view.
enum ViewState: Equatable {
    case none, loading, loaded, error(String)
}

@MainActor
final class MealProgramsViewModel: ObservableObject {
    private let viewOffSet = 2
    private var offset = 0
    private var isFetching: Bool = false
    let mealProgramRequest: MealProgramRequest
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published private(set) var filteredMealPrograms: [MealProgram] = []
    @Published var shouldSearchMeals: Bool = false
    @Published var viewState: ViewState
    @Published private(set) var visibleMealPrograms: [MealProgram] = []
    
    init(mealProgramRequest: MealProgramRequest = MealProgramRequest()) {
        self.mealProgramRequest = mealProgramRequest
        viewState = .none
        addObservers()
        loadInitialData()
    }
    
    func loadInitialData() {
        viewState = .loading
        Task {
            do {
                try await mealProgramRequest.loadMealPrograms()
                offset = 0
                visibleMealPrograms = mealProgramRequest.fetchPage(offset: offset)
                offset += visibleMealPrograms.count
                filteredMealPrograms = visibleMealPrograms
                viewState = .loaded
            } catch {
                //TODO: would do much better error handling by checking "NetworkError".
                viewState = .error("Hey there! Something went wrong... 😬")
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
        let newItems = mealProgramRequest.fetchPage(offset: offset)
        visibleMealPrograms.append(contentsOf:  newItems)
        filteredMealPrograms = visibleMealPrograms
        offset += newItems.count
    }
    
    private func shouldFetchMore(currentItem: MealProgram) -> Bool {
        guard isFetching == false else {
            return false
        }
        isFetching = true
        defer {
            isFetching = false
        }
        
        let thresholdIndex = visibleMealPrograms.index(visibleMealPrograms.endIndex, offsetBy: -viewOffSet)
        guard visibleMealPrograms.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex else {
            return false
        }
        return true
    }
}


