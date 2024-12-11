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
    private var recipeDetails: [RecipeDetail] = []
    
    func requestRecipeIngredients(recipeID: Int,
                      completion: @escaping (Result<[RecipeDetail], Error>) -> Void)  {
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
                let recipeDetails = try parse(json: data)
                DispatchQueue.main.async {
                    self.recipeDetails = recipeDetails
                    completion(.success(recipeDetails))
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
            URLQueryItem(name: "apiKey", value: "d71eab7547c442199b0231aefdc871a7"),
        ]
        return components?.url
    }
   
    
    //parses JSON files
    private func parse(json: Data) throws -> [RecipeDetail] {
        let decoder = JSONDecoder()
        let jsonRecipeDetails = try decoder.decode(RecipeDetails.self, from: json)
        self.recipeDetails = jsonRecipeDetails.results
        return recipeDetails
    }
}







