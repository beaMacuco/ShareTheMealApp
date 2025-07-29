//
//  CodableMock.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 23.07.25.
//


struct CodableMock: Codable {
    let id: Int
    let name: String
}

extension CodableMock {
    static func make() -> CodableMock {
        CodableMock(id: 1, name: "Test")
    }
}
