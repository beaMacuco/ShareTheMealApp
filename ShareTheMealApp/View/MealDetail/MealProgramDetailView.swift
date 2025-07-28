//
//  MealProgramDetailView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

//If i had more time I would add an animation like in the main app to show the inline navbar when the user scrolls passed the image.
struct MealProgramDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let mealProgram: MealProgram
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: ViewSpacing.twenty) {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: ViewSpacing.eight) {
                        OverlayHeaderImageView(title: mealProgram.name, imageUrl: mealProgram.programImageUrl)
                        VStack(alignment: .leading, spacing: ViewSpacing.eight) {
                            TagsView(tags: mealProgram.tags)
                            VStack(alignment: .leading, spacing: ViewSpacing.sixteen) {
                                Text("Overview:")
                                    .font(.title3)
                                Text(mealProgram.description)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: ViewSpacing.zero, leading: ViewSpacing.sixteen, bottom: ViewSpacing.zero, trailing: ViewSpacing.sixteen))
                    }
                }
                
                PrimaryButton(title: "Donate now") {
                    
                }
                .padding(ViewSpacing.sixteen)
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
    MealProgramDetailView(mealProgram: MealProgram.fake())
}
