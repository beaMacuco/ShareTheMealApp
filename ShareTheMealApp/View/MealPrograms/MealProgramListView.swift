//
//  MealProgramListView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct MealProgramListView<ViewModel: MealProgramsViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
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
                        .task(id: item.id) {
                            viewModel.fetchMoreIfNeeded(currentItem: item)
                        }
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                mealProgramList
                .opacity(viewModel.viewState == .loaded ? ViewOpacity.one : ViewOpacity.zero)
    
                viewState
            }
            .navigationTitle("Meal Programs")
            .task {
                await viewModel.loadInitialDataIfNeeded()
            }
        }
    }
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    MealProgramListView(viewModel: MealProgramsViewModel())
}
