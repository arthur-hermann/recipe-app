//
//  RecipeListViewController.swift
//  recipe-app
//
//  Created by Arthur Hermann on 27/11/2024.
//

import UIKit

final class RecipeListViewController: UIViewController {
    
    private var recipeListViewModel = RecipeListViewModel()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.tintColor = .blue
        searchBar.searchBarStyle = .default
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        
        self.setUp()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        requestRecipe()
    }
    
    func requestRecipe() {
        recipeListViewModel.FetchRecipe("") { result in
            switch result {
            case .success(_):
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUp() {
        self.view.backgroundColor = .systemMint
        self.view.addSubview(collectionView)
        self.view.addSubview(searchBar)
        configureConstraints()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private func searchRecipe(query: String) {
        let recipes = recipeListViewModel.recipes
        let filteredRecipes = recipes.filter({$0.title.contains(query)})
        self.collectionView.reloadData()
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
}

extension RecipeListViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension RecipeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeListViewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Failed to dequeue CustomCollectionViewCell in ViewController")
        }
        
        let url = recipeListViewModel.images[indexPath.row]
        cell.configure(with: url)
        return cell
    }
}

extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width/3) - 1.34
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
