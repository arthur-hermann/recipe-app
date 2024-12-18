//
//  CustomCollectionViewCell.swift
//  recipe-app
//
//  Created by Arthur Hermann on 29/11/2024.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage()
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setUp() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}

//MARK: - Helpers
extension CustomCollectionViewCell {
    func configure(with image: UIImage) {
        self.imageView.image = image
        self.setUp()
    }
}


