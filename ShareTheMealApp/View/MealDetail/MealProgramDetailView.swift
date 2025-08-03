//
//  MealProgramDetailView.swift
//  ShareTheMealApp
//
//

import SwiftUI

// TODO: If i had more time I would add an animation like in the main app to show the inline navbar when the user scrolls passed the image.
struct MealProgramDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MealProgramItemViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: ViewSpacing.twenty) {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: ViewSpacing.eight) {
                        OverlayHeaderImageView(title: viewModel.mealProgram.name, image: viewModel.programImage)
                        VStack(alignment: .leading, spacing: ViewSpacing.eight) {
                            TagsView(tags: viewModel.mealProgram.tags)
                            VStack(alignment: .leading, spacing: ViewSpacing.sixteen) {
                                Text(MealProgramItemViewModel.summaryTitle)
                                    .font(.title3)
                                    .accessibilityIdentifier(AccessibilityIdentifiers.summaryTitle)
                                Text(viewModel.mealProgram.description)
                                    .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramDescription)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: ViewSpacing.zero, leading: ViewSpacing.sixteen, bottom: ViewSpacing.zero, trailing: ViewSpacing.sixteen))
                    }
                }
                
                PrimaryButton(title: MealProgramItemViewModel.donateButtonTitle) {
                    viewModel.showAlert = true
                }
                .accessibilityIdentifier(AccessibilityIdentifiers.donateButton)
                .padding(ViewSpacing.sixteen)
            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramItemView)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(MealProgramItemViewModel.alertTitle), message: Text(MealProgramItemViewModel.alertMessage), dismissButton: .default(Text(MealProgramItemViewModel.dismissButtonTitle)))
            }
        }
        .toolbar {
            BackToolBarItem {
                dismiss()
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    MealProgramDetailView(viewModel: MealProgramItemViewModel(mealProgram: MealProgram.fake()))
}



