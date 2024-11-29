//
//  CustomCollectionViewCell.swift
//  recipe-app
//
//  Created by Arthur Hermann on 29/11/2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "image")
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    func configure(with image: UIImage) {
        self.myImageView.image = image
        self.setUp()
        
    }
    
    func setUp() {
        self.backgroundColor = .systemRed
        
        self.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            self.myImageView.image = nil
        }
    }
    

