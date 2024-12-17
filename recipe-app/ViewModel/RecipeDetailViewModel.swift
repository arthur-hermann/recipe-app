//
//  RecipeDetailViewModel.swift
//  recipe-app
//
//  Created by Arthur Hermann on 06/12/2024.
//

import Foundation
import UIKit

final class RecipeDetailViewModel {
    private var recipeImage = UIImage()
    private var recipeDescription: String = ""
    var recipeDetail = RecipeDetail(id: 0, title: "", vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 0, cookingMinutes: 0, pricePerServing: 0, extendedIngredients: [], readyInMinutes: 0, servings: 0, dishTypes: [], diets: [], occasions: [], instructions: "", analyzedInstructions: []) //I dont use this but xcode complains if I don't initialise recipeDetail.
    
    
    func requestRecipeIngredients(recipeID: Int,
                                  completion: @escaping (Result<RecipeDetail, Error>) -> Void)  {
        guard let url = makeURL(recipeID: recipeID) else {
            completion(.failure(RecipeError.networkError))
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let _ = error {
                completion(.failure(RecipeError.networkError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(RecipeError.unexpectedResponse))
                return
            }
            guard let data = data else {
                completion(.failure(RecipeError.noData))
                return
            }
            do {
                let recipeDetail: RecipeDetail = try JSONDecoderHelper.parse(json: data)
                
                DispatchQueue.main.async {
                    self.recipeDetail = recipeDetail
                    completion(.success(recipeDetail))
                }
                
            } catch {
                completion(.failure(RecipeError.parsingError))
            }
        }.resume()
    }
}
//MARK: - Helpers
extension RecipeDetailViewModel {
    
    private func makeURL(recipeID: Int) -> URL? {
        var components = URLComponents(string: "https://api.spoonacular.com/recipes/\(recipeID)/information")
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: "5b91aa819e6d4bc8848f4c972103e6dc"),
            URLQueryItem(name: "addRecipeInstructions", value: "true")
        ]
        return components?.url
    }
    
}

enum JSONDecoderHelper {
    static func parse<T: Decodable>(json: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedModel = try decoder.decode(T.self, from: json)
        return decodedModel
    }
}
