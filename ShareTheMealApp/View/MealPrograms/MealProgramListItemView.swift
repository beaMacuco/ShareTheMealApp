//
//  MealProgramListItemView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct MealProgramListItemView: View {
    @StateObject private var viewModel: MealProgramItemViewModel
    
    var body: some View {
        NavigationLink {
            MealProgramDetailView(viewModel: viewModel)
        } label: {
            MealProgramCardView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.loadProgramImage()
        }
    }
    
    init(mealProgram: MealProgram) {
        self._viewModel = StateObject(wrappedValue: MealProgramItemViewModel(mealProgram: mealProgram))
    }
}

#Preview {
    MealProgramListItemView(mealProgram: MealProgram.fake())
}
