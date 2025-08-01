//
//  MealProgramItemViewModel.swift
//  ShareTheMealApp
//
//

import SwiftUI

final class MealProgramItemViewModel: ObservableObject {
    private static let placeholderImage: String = "ImagePlaceholder"
    private let imageLoader: ImageLoading
    let mealProgram: MealProgram
    @Published private(set) var programImage: Image
    @Published var showAlert: Bool = false
    
    init(mealProgram: MealProgram, imageLoader: ImageLoading = ImageLoader()) {
        self.mealProgram = mealProgram
        self.imageLoader = imageLoader
        self.programImage = Image(Self.placeholderImage)
    }
    
    @MainActor
    func loadProgramImage() {
        Task {
            guard let image = await imageLoader.fetchImage(from: mealProgram.imageUrl) else {
                return
            }
            programImage = image
        }
    }
}
