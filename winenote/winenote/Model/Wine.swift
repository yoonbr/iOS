//
//  Wine.swift
//  winenote
//
//  Created by boreum yoon on 2021/03/16.
//

import Foundation
import UIKit

// Model - Wine으로 이동
struct WineList: Codable {

    struct List: Codable {
        let winenum: Int
        let price: Int
        let wineimg: String
        let winename: String
    }
    
    let list: [List]
}
