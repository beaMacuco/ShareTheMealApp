//
//  ProgramProgressView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct ProgramProgressView: View {
    let mealProgram: MealProgram
    
    var body: some View {
        ProgressView(value: mealProgram.progressPercentage) {
            HStack {
                Text(mealProgram.amounts)
                    .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramAmountText)
                Spacer()
                Text(mealProgram.progressPercentageString)
                    .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramProgressPercentageText)
                    .foregroundStyle(.gray)
            }
            .font(.footnote)
        }
        .tint(.green)
    }
}

#Preview {
    ProgramProgressView(mealProgram: MealProgram.fake())
}
