//
//  Forecast.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/19.
//

import Foundation

// Playground 의 Forecast 코드 복사
struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    
    struct ListItem: Codable {
        
        let dt: Int
        
        // Main 구조체 생성 후 temp값만 뽑아내기
        struct Main: Codable {
            let temp: Double
        }
        
        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        
        let weather: [Weather]
    }
    
    // List가 배열이므로 속성을 추가하고 type을 배열로 선언
    let list: [ListItem]
}
