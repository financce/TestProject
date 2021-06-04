//
//  Model.swift
//  TestProject
//
//  Created by slava on 04/06/2021.
//


import Foundation

// MARK: - ModelApp
struct ModelApp: Codable {
    let data: [Datum]
    let view: [String]
}

// MARK: - Datum
struct Datum: Codable {
    let name: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}

//MARK: MODEL FOR LIST
struct ModelAppList: Codable, Identifiable {
    var id = UUID().uuidString
    let name: String
    let nameView: String
    let image: String
    let selector: Int
    let variants: [Variant]
}
