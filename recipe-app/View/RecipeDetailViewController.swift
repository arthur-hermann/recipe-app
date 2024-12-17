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
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.removeAllSymbolEffects()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 30)
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
    
        ingredientsLabel.backgroundColor = .white
        ingredientsLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.sizeToFit()
        
        return ingredientsLabel
    }()
    
    private lazy var instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        
        instructionsLabel.backgroundColor = .white
        instructionsLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.numberOfLines = 0
        instructionsLabel.sizeToFit()
        instructionsLabel.textAlignment = .left
        
        return instructionsLabel
    }()
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureConstraints()
        recipeDetailViewModel.requestRecipeIngredients(recipeID: recipe.id) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(_):
                let imageURL = URL(string: self.recipe.image!)
                image.load(url: imageURL!)
                configureLabels()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(image)
        
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(instructionsLabel)
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
        
    }()
    
    private func configureLabels () {
        
        let ingredients = recipeDetailViewModel.recipeDetail.extendedIngredients
        ingredientsLabel.text = "Ingredients: \n\n"
        
        for ingredient in ingredients {
            ingredientsLabel.text = "\(ingredientsLabel.text ?? "") \(Int(round(ingredient.amount))) \(ingredient.unit) \(ingredient.nameClean ?? ingredient.originalName!)\n\n"
        }
        
        instructionsLabel.text = "Instructions: \n\n"

        let analyzedInstructions = recipeDetailViewModel.recipeDetail.analyzedInstructions
        for step in analyzedInstructions[0].steps {
            instructionsLabel.text = "\(instructionsLabel.text ?? "") Step \(step.number):\n\n \(step.step)\n\n"
        }
        
    }
    
    private func configureConstraints() {
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate(
            [
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -10),
                
                image.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                image.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor, constant: -20),
                image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                
                ingredientsLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
                ingredientsLabel.bottomAnchor.constraint(equalTo: instructionsLabel.topAnchor),
                ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                instructionsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor),
                instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
        
    }
}
