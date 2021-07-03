//
//  AllCategoriesResponse.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/07/03.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
