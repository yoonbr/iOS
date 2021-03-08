//
//  MovieVO.swift
//  MovieInformation
//
//  Created by boreum yoon on 2021/03/07.
//

// 사용되는 자료구조
import Foundation
// 화면에 보여지는 것
import UIKit

struct MovieVO {
    // 제목, 장르, 링크, 평점, 이미지주소, 이미지
    var movieId: Int!
    var title: String!
    var genre: String!
    var link: String!
    var rating: Double!
    var thumbnail: String!
    
    var image: UIImage!
    
}
