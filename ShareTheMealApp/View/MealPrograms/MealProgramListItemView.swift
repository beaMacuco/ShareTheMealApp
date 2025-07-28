//
//  MealProgramListItemView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

class MealProgramItemViewModel: ObservableObject {
    private static let placeholderImage: String = "ImagePlaceholder"
    private let imageLoader: ImageLoading
    @Published private(set) var mealProgram: MealProgram
    @Published private(set) var programImage: Image
    
    init(mealProgram: MealProgram, imageLoader: ImageLoading = ImageLoader()) {
        self.mealProgram = mealProgram
        self.imageLoader = imageLoader
        self.programImage = Image(Self.placeholderImage)
    }
    
    @MainActor
    func loadProgramImage() {
        Task {
            do {
                programImage = try await imageLoader.fetchImage(from: mealProgram.imageUrl)
            } catch {
                print(error)
            }
        }
    }
}

struct MealProgramListItemView: View {
    @StateObject private var viewModel: MealProgramItemViewModel
    
    var body: some View {
        NavigationLink {
            MealProgramDetailView(viewModel: viewModel)
        } label: {
            MealProgramCardView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.loadProgramImage()
        }
    }
    
    init(mealProgram: MealProgram) {
        self._viewModel = StateObject(wrappedValue: MealProgramItemViewModel(mealProgram: mealProgram))
    }
}

#Preview {
    MealProgramListItemView(mealProgram: MealProgram.fake())
}
