//
//  RecipeDetailViewController.swift
//  recipe-app
//
//  Created by Arthur Hermann on 06/12/2024.
//

import Foundation
import UIKit

final class RecipeDetailViewController: UIViewController {
    private var recipeListViewModel = RecipeListViewModel()
    private var recipeDetailViewModel = RecipeDetailViewModel()
    private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        recipeDetailViewModel.requestRecipeIngredients(recipeID: Int(recipe.id)) { result in
            switch result {
            case .success(_):
                print(self.recipe.id)
                print("success")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUp() {
        self.view.addSubview(stackView)
        configureConstraints()
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .brown
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

