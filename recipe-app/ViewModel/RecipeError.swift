//
//  RecipeError.swift
//  recipe-app
//
//  Created by Arthur Hermann on 03/12/2024.
//

import Foundation

enum RecipeError: Error {
    case invalidURL
    case networkError
    case unexpectedResponse
    case noData
    case parsingError
}
