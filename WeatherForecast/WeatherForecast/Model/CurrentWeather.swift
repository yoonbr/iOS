//
//  CurrentWeather.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/19.
//

import Foundation

// Playground 의 CurrentWeather 코드 복사
struct CurrentWeather: Codable {
    
    // 속성의 이름과 key의 이름, 값의 형식이 완전히 동일해야함
    let dt: Int
    
    // 구조체를 하나 만든 다음 속성을 추가, 배열이 아닌 단일값
    // json은 [ ] 배열, { } dictionary 저장
    // nested type으로 선언, type이기 때문에 Upper carmelcase 선언
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    // 속성 추가 - 이름과 key의 이름이 동일해야하며 형식은 선언한 구조체로 선언
    // weather의 값은 배열이므로 [Weather]로 선언해야 함
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let main: Main
}
