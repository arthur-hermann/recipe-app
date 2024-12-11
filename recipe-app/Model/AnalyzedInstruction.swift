//
//  AnalyzedInstruction.swift
//  recipe-app
//
//  Created by Arthur Hermann on 11/12/2024.
//

import Foundation

struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}
