//
//  RecipeListViewModel.swift
//  recipe-app
//
//  Created by Arthur Hermann on 27/11/2024.
//

import UIKit

final class RecipeListViewModel {
    var recipes = [Recipe]()
    var images: [String] = []
    
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
                    self.images = recipes.map { $0.image ?? "germany" }
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
            URLQueryItem(name: "number", value: "1")
        ]
        return components?.url
    }
    
    //parses JSON files
    private func parse(json: Data) throws -> [Recipe] {
        let decoder = JSONDecoder()
        let jsonRecipes = try decoder.decode(Recipes.self, from: json)
        self.recipes = jsonRecipes.results
        return recipes
    }
}

extension UIImageView {
    public func setImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        self.image = placeholder
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
}

