////
////  listRestaurantsTest.swift
////  recipe-appTests
////
////  Created by Arthur Hermann on 27/11/2024.
////
//
//import XCTest
//import Testing
//@testable import recipe_app
//
//protocol RecipeListProtocol {
//    var viewModel: RecipeListViewModel { get }
//}
//
//final class listRestaurantsTest: XCTestCase, RecipeListProtocol {
//    var viewModel: recipe_app.RecipeListViewModel
//    
//    init(viewModel: recipe_app.RecipeListViewModel) {
//        self.viewModel = viewModel
//        super.init()
//    }
//    
//    override func setUp() {
//        viewModel = RecipeListViewModel()
//    }
//    
//    func testRecipeListNotEmpty() {
//        let expectation = expectation(description: "Searching for pasta")
//        let viewModel = RecipeListViewModel()
//        
//        viewModel.searchRecipe("pasta") { _ in
//            XCTAssertFalse(viewModel.recipes.isEmpty)
//            expectation.fulfill()
//        }
//    }
//    
//    func testCorrectRecipeTitle() {
//        let expectation = expectation(description: "Searching for pasta")
//        let viewModel = RecipeListViewModel()
//        
//        viewModel.searchRecipe("pasta") {result in
//            for recipe in viewModel.recipes {
//                XCTAssertTrue(recipe.title.contains("pasta"))
//            }
//            expectation.fulfill()
//        }
//    }
//    
//    func testCorrectNumberOfRecipes() {
//        let expectation = expectation(description: "Searching for pasta")
//        let viewModel = RecipeListViewModel()
//        
//        viewModel.searchRecipe("pasta") {result in
//            XCTAssertEqual(viewModel.recipes.count, 20)
//            expectation.fulfill()
//            
//        }
//        
//    }
//}
//
//
