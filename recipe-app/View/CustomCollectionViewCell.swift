//
//  CustomCollectionViewCell.swift
//  recipe-app
//
//  Created by Arthur Hermann on 29/11/2024.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "image")
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setUp() {
        
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

//MARK: - Helpers
extension CustomCollectionViewCell {
     func configure(with image: UIImage) {
        self.myImageView.image = image
        self.setUp()
    }
}
    

