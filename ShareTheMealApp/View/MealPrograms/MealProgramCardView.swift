//
//  MealProgramCardView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct MealProgramCardView: View {
    let mealProgram: MealProgram
    
    var body: some View {
        CardView {
            OverlayHeaderImageView(title: mealProgram.name, imageUrl: mealProgram.programImageUrl)
            
            VStack(alignment: .leading, spacing: ViewSpacing.twelve) {
                TagsView(tags: mealProgram.tags)
                ProgramProgressView(mealProgram: mealProgram)
            }
            .padding(EdgeInsets(top: ViewSpacing.zero, leading: ViewSpacing.sixteen, bottom: ViewSpacing.sixteen, trailing: ViewSpacing.sixteen))
        }
    }
}

#Preview {
    MealProgramCardView(mealProgram: MealProgram.fake())
}
