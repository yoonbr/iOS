//
//  Note.swift
//  winenote
//
//  Created by boreum yoon on 2021/05/07.
//

import Foundation
import UIKit

struct NoteList: Codable {

    struct List: Codable {
        let notenum: Int
        let winenum: Int
        let nickname: String
        let notedate: String
        let price: Int
        let firstword: String
        let secondword: String
        let wineimg: String
        let winename: String
    }
    
    let list: [List]
}

struct NoteListData {
    
    let nickname: String
    let notedate: String
    let price: Int
    let firstword: String
    let secondword: String
    
}
