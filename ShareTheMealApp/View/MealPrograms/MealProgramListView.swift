//
//  MealProgramListView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 27.07.25.
//

import SwiftUI

struct MealProgramListView: View {
    @StateObject private var viewModel = MealProgramsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                ForEach(viewModel.filteredMealPrograms, id: \.self) { item in
                    MealProgramListItemView(mealProgram: item)
                        .onAppear {
                            viewModel.fetchMoreIfNeeded(currentItem: item)
                        }
                }
            }
            .searchable(text: $viewModel.searchText)
            .onAppear() {
                viewModel.loadInitialData()
            }
            .navigationTitle("Meal Programs")
        }
    }
}

#Preview {
    MealProgramListView()
}
