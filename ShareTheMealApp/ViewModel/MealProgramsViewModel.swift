//
//  MealProgramsViewModel.swift
//  ShareTheMealApp
//
//

import SwiftUI
import Combine

/// Keeps track of the view state to be displayed in the view.
enum ViewState: Equatable {
    case loading, loaded, error(String)
}

final class MealProgramsViewModel: ObservableObject {
    static let searchBarPrompt: String = "Search Meal Programs"
    static let navigationTitle: String = "Search Meal Programs"
    static let errorMessage: String = "Hey there! Something went wrong... 😬"
    private var hasLoadedInitialData = false
    private let viewOffSet = 2
    private(set) var offset = 0
    private var isFetching: Bool = false
    let mealProgramRequest: MealProgramRequestable
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var filteredMealPrograms: [MealProgram] = []
    @Published var shouldSearchMeals: Bool = false
    @Published var viewState: ViewState = .loading
    @Published private(set) var visibleMealPrograms: [MealProgram] = []
    
    init(mealProgramRequest: MealProgramRequestable = MealProgramRequest()) {
        self.mealProgramRequest = mealProgramRequest
    }
    
    @MainActor
    func loadInitialDataIfNeeded() async {
        addObservers()
        guard !hasLoadedInitialData else {
            return
        }
        await loadInitialData()
        hasLoadedInitialData = true
    }
    
    @MainActor
    private func loadInitialData() async {
        do {
            try await mealProgramRequest.loadMealPrograms()
            await MainActor.run {
                visibleMealPrograms = mealProgramRequest.fetchPage(offset: offset)
                offset += visibleMealPrograms.count
                filteredMealPrograms = visibleMealPrograms
                viewState = .loaded
            }
        } catch {
            await MainActor.run {
                //TODO: would do much better error handling by checking "NetworkError".
                viewState = .error(Self.errorMessage)
            }
        }
    }
    
    @MainActor
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
    
    @MainActor
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


