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
                                Text("Overview:")
                                    .font(.title3)
                                Text(viewModel.mealProgram.description)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: ViewSpacing.zero, leading: ViewSpacing.sixteen, bottom: ViewSpacing.zero, trailing: ViewSpacing.sixteen))
                    }
                }
                
                PrimaryButton(title: "Donate now") {
                    viewModel.showAlert = true
                }
                .padding(ViewSpacing.sixteen)
            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("MealProgramDetailView")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("We have received your donation"), message: Text("Thank you for your interest :)"), dismissButton: .default(Text("OK")))
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
