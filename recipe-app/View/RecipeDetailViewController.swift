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
    
    //Xcode complains if I don't initialise labels before init.
    let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    let isVegetarianLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let isGlutenFreeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let pricePerServingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let ingredientsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let instructionsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    
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
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
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
    
    private func SetUp() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
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
        
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        isVegetarianLabel.text = "Vegetarian: \(String(recipeDetailViewModel.recipeDetail.vegetarian!))"
        isVegetarianLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        isVegetarianLabel.backgroundColor = .blue
        isVegetarianLabel.sizeToFit()
        isVegetarianLabel.translatesAutoresizingMaskIntoConstraints = false
        
        isGlutenFreeLabel.text = "Gluten free: \(String(recipeDetailViewModel.recipeDetail.glutenFree!))"
        isGlutenFreeLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        isGlutenFreeLabel.backgroundColor = .blue
        isGlutenFreeLabel.sizeToFit()
        
        let ingredients = recipeDetailViewModel.recipeDetail.extendedIngredients
        for ingredient in ingredients {
            ingredientsLabel.text = "\(ingredientsLabel.text ?? "") \(Int(round(ingredient.amount))) \(ingredient.unit) \(ingredient.nameClean)\n\n"
        }
        
        ingredientsLabel.backgroundColor = .white
        ingredientsLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.sizeToFit()
        
        let analyzedInstructions = recipeDetailViewModel.recipeDetail.analyzedInstructions
        for step in analyzedInstructions[0].steps {
            instructionsLabel.text = "\(instructionsLabel.text ?? "") Step \(step.number): \(step.step)\n\n"
        }
        
        instructionsLabel.backgroundColor = .white
        instructionsLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.numberOfLines = 0
        instructionsLabel.sizeToFit()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -30),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 100),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 350),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            ingredientsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ingredientsLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 380),
            ingredientsLabel.bottomAnchor.constraint(equalTo: instructionsLabel.topAnchor, constant: 50),
            
            instructionsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 30),
            instructionsLabel.widthAnchor.constraint(equalToConstant: 380),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
