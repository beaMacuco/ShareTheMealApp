//
//  MealProgramListItemView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct MealProgramListItemView: View {
    let mealProgram: MealProgram
    
    var body: some View {
        NavigationLink {
            MealProgramDetailView(mealProgram: mealProgram)
        } label: {
            MealProgramCardView(mealProgram: mealProgram)
        }
    }
}

#Preview {
    MealProgramListItemView(mealProgram: MealProgram.fake())
}
