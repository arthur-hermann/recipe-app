//
//  Ingredients.swift
//  recipe-app
//
//  Created by Arthur Hermann on 10/12/2024.
//

import Foundation

struct Ingredient: Codable {
    let id: Int
    let aisle: String?
    let image: String?
    let consistency: String?
    let name: String
    let nameClean: String?
    let original: String?
    let originalName: String?
    let amount: Double
    let unit: String
}
