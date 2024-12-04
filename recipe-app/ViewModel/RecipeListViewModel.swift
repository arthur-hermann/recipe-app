//
//  RecipeListViewModel.swift
//  recipe-app
//
//  Created by Arthur Hermann on 27/11/2024.
//

import UIKit

final class RecipeListViewModel {
    var recipes = [Recipe]()
    var images: [UIImage] = []
    
    func searchRecipe(_ query: String,
                      completion: @escaping (Result<[Recipe], Error>) -> Void)  {
        guard let url = makeURL(query: query) else {
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
                let recipes = try parse(json: data)
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

//MARK: - Helpers
extension RecipeListViewModel {
    private func makeURL(query: String) -> URL? {
        var components = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: "d71eab7547c442199b0231aefdc871a7"),
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
            self.recipes = jsonRecipes.results
        }
        catch  {
            RecipeError.parsingError
        }
        return recipes
    }
    
    func fetchImages(_ query: String) {
        for recipe in recipes {
            guard let imageURL = recipe.image else {
                RecipeError.invalidURL
                return
            }
            
            guard let url = URL(string: imageURL) else {
                RecipeError.invalidURL
                return
            }
            
            let session = URLSession.shared
            session.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data else {
                    RecipeError.parsingError
                    return
                }
                guard let image = try? UIImage(data: data)! else {
                    RecipeError.parsingError
                    return
                }
                self?.images.append(image)
            }.resume()
            
        }

    }
}

