//
//  UIImageViewExtensions.swift
//  recipe-app
//
//  Created by Arthur Hermann on 16/12/2024.
//

import UIKit

extension UIImageView {
    public func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    public func setImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        self.image = placeholder
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
}
