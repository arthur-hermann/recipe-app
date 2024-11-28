//
//  listRestaurantsTest.swift
//  recipe-appTests
//
//  Created by Arthur Hermann on 27/11/2024.
//

import XCTest
import Testing
@testable import recipe_app

final class listRestaurantsTest: XCTestCase {
    
    func testRecipeListNotEmpty() {
        DispatchQueue.global(qos: .background).async {
            let vm = RecipeListViewModel()
            vm.searchRecipe("pasta")
            XCTAssertFalse(vm.recipes.isEmpty)
            
        }
    }
    
    func testCorrectRecipeTitle() {
        DispatchQueue.global(qos: .background).async {
            let vm = RecipeListViewModel()
            vm.searchRecipe("pasta")
            let recipes = vm.recipes
            for recipe in recipes {
                XCTAssertTrue(recipe.title.contains("pasta"))
            }
        }
    }
    func testCorrectNumberOfRecipes() {
        DispatchQueue.global(qos: .background).async {
            let vm = RecipeListViewModel()
            vm.searchRecipe("pasta")
            XCTAssertEqual(vm.recipes.count, 20)
        }
    }
}

