//
//  RecipeDetails.swift
//  recipe-app
//
//  Created by Arthur Hermann on 11/12/2024.
//

import Foundation
struct RecipeDetails: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes, cookingMinutes: Double?
    let aggregateLikes, healthScore: Int
    let creditsText, license, sourceName: String
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String
    let imageType, summary: String
    let dishTypes, diets, occasions: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let spoonacularScore: Double
    let spoonacularSourceURL: String
}
