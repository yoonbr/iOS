//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/22.
//

import Foundation
// 위치서비스 구현 필수 프레임워크 CoreLocation
import CoreLocation

// Singleton 클래스 추가
class LocationManager: NSObject {
    static let shared = LocationManager()
    private override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        super.init()
    }
    
    let manager: CLLocationManager
}

