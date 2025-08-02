//
//  MealProgramListView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct MealProgramListView: View {
    @StateObject private var viewModel: MealProgramsViewModel
    
    @ViewBuilder
    private var viewState: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .error(let error):
            Text(error)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var mealProgramList: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.filteredMealPrograms, id: \.self) { item in
                    MealProgramListItemView(mealProgram: item)
                        .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramItemView)
                        .task(id: item.id) {
                            viewModel.fetchMoreIfNeeded(currentItem: item)
                        }
                }
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramScrollView)
        .searchable(text: $viewModel.searchText, prompt: MealProgramsViewModel.searchBarPrompt)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                mealProgramList
                    .opacity(viewModel.viewState == .loaded ? ViewOpacity.one : ViewOpacity.zero)
                viewState
            }
            .navigationTitle(MealProgramsViewModel.navigationTitle)
            .task {
                await viewModel.loadInitialDataIfNeeded()
            }
        }
    }
    
    init(viewModel: MealProgramsViewModel = MealProgramsViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    MealProgramListView()
}
