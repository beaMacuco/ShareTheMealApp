//
//  MealProgramCardView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct MealProgramCardView: View {
    @ObservedObject var viewModel: MealProgramItemViewModel
    
    var body: some View {
        CardView {
            OverlayHeaderImageView(title: viewModel.mealProgram.name, image: viewModel.programImage)
            VStack(alignment: .leading, spacing: ViewSpacing.twelve) {
                TagsView(tags: viewModel.mealProgram.tags)
                ProgramProgressView(mealProgram: viewModel.mealProgram)
            }
            .padding(EdgeInsets(top: ViewSpacing.zero, leading: ViewSpacing.sixteen, bottom: ViewSpacing.sixteen, trailing: ViewSpacing.sixteen))
        }
    }
}

#Preview {
    MealProgramCardView(viewModel: MealProgramItemViewModel(mealProgram: MealProgram.fake()))
}
