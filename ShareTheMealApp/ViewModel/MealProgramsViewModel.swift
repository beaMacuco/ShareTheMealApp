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

@MainActor
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
    @Published private(set) var filteredMealPrograms: [MealProgram] = []
    @Published private(set) var visibleMealPrograms: [MealProgram] = []
    @Published var viewState: ViewState = .loading
    
    init(mealProgramRequest: MealProgramRequestable = MealProgramRequest()) {
        self.mealProgramRequest = mealProgramRequest
        addObservers()
    }
    
    /// Makes sure data is only loaded once.
    func loadInitialDataIfNeeded() async {
        guard !hasLoadedInitialData else {
            return
        }
        await loadInitialData()
        hasLoadedInitialData = true
    }
    
    /// Loads meal programs and sets initial variables.
    /// Chages the view state to either loaded or error with message.
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
    
    /// Adds combine observers
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
    
    /// Concentrates filters into one single place taking both for search text and visible programs into account every time.
    private func applySearchFilter() {
        if searchText.isEmpty {
            filteredMealPrograms = visibleMealPrograms
        } else {
            filteredMealPrograms = mealProgramRequest.searchItems(query: searchText)
        }
    }
    
    /// Sets up pagination logic for fetching data lazily.
    func fetchMoreIfNeeded(currentItem: MealProgram) {
        guard shouldFetchMore(currentItem: currentItem) else {
            return
        }
        let newItems = mealProgramRequest.fetchPage(offset: offset)
        visibleMealPrograms.append(contentsOf:  newItems)
        filteredMealPrograms = visibleMealPrograms
        offset += newItems.count
    }
    
    /// Checks if there is a need to fetch more based on the currently created item.
    /// Defers fetch if it is already fetching.
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


