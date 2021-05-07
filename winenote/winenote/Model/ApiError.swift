//
//  ApiError.swift
//  winenote
//
//  Created by boreum yoon on 2021/05/06.
//

import Foundation

enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
