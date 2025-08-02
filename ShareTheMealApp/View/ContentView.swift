//
//  ContentView.swift
//  ShareTheMealApp
//
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        MealProgramListView(viewModel: MealProgramsViewModel())
    }
}

