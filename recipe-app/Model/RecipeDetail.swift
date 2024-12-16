//
//  RecipeDetail.swift
//  recipe-app
//
//  Created by Arthur Hermann on 11/12/2024.
//

import Foundation
struct RecipeDetail: Codable {
    let id: Int
    let title: String
    let vegetarian: Bool?
    let vegan: Bool?
    let glutenFree: Bool?
    let dairyFree: Bool?
    let preparationMinutes: Double?
    let cookingMinutes: Double?
    let pricePerServing: Double?
    let extendedIngredients: [Ingredient]
    let readyInMinutes: Int?
    let servings: Int?
    let dishTypes: [String]?
    let diets: [String]?
    let occasions: [String]?
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
}
