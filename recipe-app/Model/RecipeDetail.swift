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
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let preparationMinutes, cookingMinutes: Double?
    let pricePerServing: Double
    let extendedIngredients: [Ingredient]
    let readyInMinutes, servings: Int
    let dishTypes, diets, occasions: [String]
    let instructions: String
}
