//
//  Ingredients.swift
//  recipe-app
//
//  Created by Arthur Hermann on 10/12/2024.
//

import Foundation

struct Ingredients: Codable {

    
    let id: Int
    let aisle, image, consistency, name: String
    let nameClean, original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}
