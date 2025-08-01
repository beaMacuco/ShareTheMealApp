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
                Text("\(mealProgram.raisedAmount) out of \(mealProgram.goalAmount) \(mealProgram.goalAmount == 1 ? "meal" : "meals")")
                Spacer()
                Text(mealProgram.progressPercentageString)
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
