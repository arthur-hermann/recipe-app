//
//  RecipeListViewModel.swift
//  recipe-app
//
//  Created by Arthur Hermann on 27/11/2024.
//

import UIKit

final class RecipeListViewModel {
    private let apiKey = "5b91aa819e6d4bc8848f4c972103e6dc"
    var recipes = [Recipe]()
    
    private func makeURL(query: String) -> URL? {
        var components = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "number", value: "20")
        ]
        return components?.url
    }
    //parses JSON files
    private func parse(json: Data) throws -> [Recipe] {
        do {
            let decoder = JSONDecoder()
            let jsonRecipes = try decoder.decode(Recipes.self, from: json)
            recipes = jsonRecipes.results
            
        }
        catch  {
            RecipeError.parsingError
        }
        return recipes
    }
    
    private enum RecipeError: Error {
        case invalidURL, networkError, unexpectedResponse, noData, parsingError
    }
    
    func searchRecipe(_ query: String,
                      completion: @escaping (Result<[Recipe], Error>) -> Void)  {
        guard let url = makeURL(query: query) else {
            completion(.failure(RecipeError.networkError))
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
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
                let recipes = try self.parse(json: data)
                DispatchQueue.main.async {
                    self.recipes = recipes
                    completion(.success(recipes))
                }
            } catch {
                completion(.failure(RecipeError.parsingError))
            }
        }.resume()
    }
}
