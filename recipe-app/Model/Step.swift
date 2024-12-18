//
//  Step.swift
//  recipe-app
//
//  Created by Arthur Hermann on 11/12/2024.
//

import Foundation

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ent]
    let equipment: [Ent]
    let length: Length?
}
