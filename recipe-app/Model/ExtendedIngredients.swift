//
//  ExtendedIngredient.swift
//  recipe-app
//
//  Created by Arthur Hermann on 11/12/2024.
//

import Foundation

struct ExtendedIngredient: Codable {
    let id: Int
    let aisle, image, consistency, name: String
    let nameClean, original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}
