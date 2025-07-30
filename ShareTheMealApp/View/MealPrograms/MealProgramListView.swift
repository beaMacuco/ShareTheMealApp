//
//  MealProgramListView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 27.07.25.
//

import SwiftUI

struct MealProgramListView: View {
    @StateObject private var viewModel = MealProgramsViewModel()
    
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
}

#Preview {
    MealProgramListView()
}
