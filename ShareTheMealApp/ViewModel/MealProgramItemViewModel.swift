//
//  MealProgramItemViewModel.swift
//  ShareTheMealApp
//
//

import SwiftUI

@MainActor
final class MealProgramItemViewModel: ObservableObject {
    private static let placeholderImage: String = "ImagePlaceholder"
    static let summaryTitle: String = "Overview"
    static let donateButtonTitle: String = "Donate"
    static let alertTitle = "We have received your donation"
    static let alertMessage = "Thank you for your interest :)"
    static let dismissButtonTitle = "OK"
    private let imageLoader: ImageLoading
    let mealProgram: MealProgram
    @Published private(set) var programImage: Image
    @Published var showAlert: Bool = false
    
    init(mealProgram: MealProgram, imageLoader: ImageLoading = ImageLoader()) {
        self.mealProgram = mealProgram
        self.imageLoader = imageLoader
        self.programImage = Image(Self.placeholderImage)
    }
    
    func loadProgramImage() {
        Task {
            guard let image = await imageLoader.fetchImage(from: mealProgram.imageUrl) else {
                return
            }
            programImage = image
        }
    }
}
