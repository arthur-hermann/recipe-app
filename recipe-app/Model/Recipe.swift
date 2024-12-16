//
//  Recipe.swift
//  recipe-app
//
//  Created by Arthur Hermann on 27/11/2024.
//
import Foundation

struct Recipe: Codable {
    let id: Int
    var title: String
    var image: String?
    var imageType: String?
}
