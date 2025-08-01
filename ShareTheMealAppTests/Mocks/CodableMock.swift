//
//  CodableMock.swift
//  ShareTheMealApp
//
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
