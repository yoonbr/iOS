//
//  ApiError.swift
//  winenote
//
//  Created by boreum yoon on 2021/05/06.
//

import Foundation

// 에러형식 선언
// error protocol을 채용한 열거형으로 선언
enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
