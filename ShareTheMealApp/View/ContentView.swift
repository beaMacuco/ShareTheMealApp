//
//  ContentView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct ContentView: View {
    private let dependencyContainer: DependencyContainer = .shared
    
    var body: some View {
        MealProgramListView(viewModel: dependencyContainer.mealProgramsViewModel)
    }
}

#Preview {
    ContentView()
}
