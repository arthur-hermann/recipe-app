//
//  RecipeListViewModel.swift
//  recipe-app
//
//  Created by Arthur Hermann on 27/11/2024.
//

import Foundation
import UIKit

 class RecipeListViewModel{
    let key = "5b91aa819e6d4bc8848f4c972103e6dc"
    var recipes = [Recipe]()
    
     /*
      Retrieves first 20 recipes matching the user's search.
      */
     func searchRecipe(_ query: String) {
         guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(key)&query=\(query)&number=20") else {return}
         
         DispatchQueue.global(qos: .background).async { [weak self] in
       
             /*
              Requests recipes from API and adds them to recipe list if the request is successful.
              */
         let session = URLSession.shared
             session.dataTask(with: url) { data, response, error in
                 if let response = response{
                     if let data = data {
                         if let httpResponse = response as? HTTPURLResponse {
                             if httpResponse.statusCode == 200 {
                                 self?.parse(json: data)
                             } else {
                                 print("Unexpected status code: \(httpResponse.statusCode)")
                             }
                         }
                     }
                 }
             }
         }
     }
    
     
     /*
      Parses recipes from JSON and adds them to recipe list.
      */
     func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonRecipes = try? decoder.decode(Recipes.self, from: json) {
            print(jsonRecipes.results)
            recipes = jsonRecipes.results
        }
    }
}


