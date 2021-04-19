//
//  ApiError.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/19.
//

import Foundation

// Playground의 error형식 선언 코드 붙여넣기
// swift에서 error형식을 선언할 때는 대부분 error protocol을 채용한 열거형으로 선언
enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
