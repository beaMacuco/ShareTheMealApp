//
//  MealProgram.swift
//  ShareTheMealApp
//
//

import Foundation

struct MealProgram: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let country: String
    let countryCode: String
    let description: String
    let beneficiaries: Int
    let imageUrl: String
    let location: String
    let status: String
    let goalAmount: Int
    let raisedAmount: Int
    let category: String
    let startDate: Date
    let tags: [String]
    
    var programImageUrl: URL? {
        URL(string: imageUrl)
    }
    
    var progressPercentage: Double {
        Double(raisedAmount)/Double(goalAmount)
    }
    
    var progressPercentageString: String {
        "\(Int(progressPercentage * 100))%"
    }
}

extension MealProgram {
    static func fake(id: Int = 1, name: String = "test program") -> MealProgram {
        MealProgram(id: id, name: name, country: "Germany", countryCode: "DE", description: "A food program", beneficiaries: 300, imageUrl: "test.com", location: "Berlin", status: "Done", goalAmount: 20, raisedAmount: 10, category: "food program", startDate: Date(), tags: ["test program", "Berlin"])
    }
}
