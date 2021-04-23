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
        
        // manager 초기화
        manager = CLLocationManager()
        // 정확도 설정 = 3km 설정
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        super.init()
        
        manager.delegate = self
    }
    
    // 속성으로 manager 추가 :CLLocationManager
    let manager: CLLocationManager
    
    // parsing된 주소를 저장하는 속성 추가
    var currentLocationTitle: String? {
        // property observer 추가
        didSet {
            // 좌표를 담을 Dictionary 선언
            var userInfo = [AnyHashable: Any]()
            if let location = currentLocation {
                userInfo["location"] = location
            }
            
            NotificationCenter.default.post(name: Self.currentLocationDidUpdated, object: nil, userInfo: userInfo)
        }
    }
    
    var currentLocation: CLLocation?
    
    // 새로운 Notification 추가
    static let currentLocationDidUpdated = Notification.Name(rawValue: "currentLocationDidUpdated")
    
    
    func updateLocation() {
        // corelocation에서 허가상태를 나타내는 형식 - CLAuthorizationStatus
        let status: CLAuthorizationStatus
        
        // 허가상태 확인 - 버전마다 다름
        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            requestAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .denied, .restricted:
            print("not available")
        default:
            print("unknown")
        }
    }
}

// CLLocationManagerDelegate를 채용한 extension 생성
extension LocationManager: CLLocationManagerDelegate {
    // 사용허가 요청, 현재 위치 요청 메소드 추가
    // 외부에서 호출하지 못하도록 private
    private func requestAuthorization() {
        // 권한 요청 코드 구현 - 매니저가 제공하는 메소드를 호출
        // background에서도 위치정보가 필요할때 사용
        // manager.requestAlwaysAuthorization()
        // 앱을 실행하는 동안에만 위치정보가 필요할때 사용
        manager.requestWhenInUseAuthorization()
    }
    
    private func requestCurrentLocation() {
        // 현재위치를 반복적으로 받을 때
        // manager.startUpdatingLocation()
        // 현재위치 일회성 요청
        manager.requestLocation()
    }
    
    private func updateAddress(from location: CLLocation) {
        // parameter로 전달된 좌표를 주소 문자열로 변환 - Geocoding
        // 주소를 좌표로 변경 - forwardGeocoding, 좌표를 주소로 바꾸는 것 - reverseGeocoding
        // geocoding을 자동으로 처리해주는 객체를 이용 - CLGeocoder
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print(error)
                self?.currentLocationTitle = "unknown"
                return
            }
            // placemarks 출력할 때는 반드시 내가 원하는 값이 저장되어있는 속성인지 확인
            if let placemark = placemarks?.first {
                if let gu = placemark.locality, let dong = placemark.subLocality {
                    self?.currentLocationTitle = "\(gu) \(dong)"
                } else {
                    self?.currentLocationTitle = placemark.name ?? "Unknown"
                }
            }
            
            print(self?.currentLocationTitle)
        }
        
    }
    
    // 허가상태가 바뀌면 호출되는 메소드 추가
    // iOS 14.0 이상이 설치된 경우에만 locationManagerDidChangeAuthorization 메소드 호출
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // authorizationStatus - 14.0 에 새롭게 추가됨
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            // 사용자가 위치정보를 사용할 수 있게 허가한 상태라면 requestCurrentLocation 호출
            requestCurrentLocation()
        case .notDetermined, .denied, .restricted:
            // 위치정보 사용을 허가하지 않은 상태인 경우 print로 경고를 출력
            print("not available")
        default:
            print("unknown")
        }
    }
    
    // 14버전 이전에서 사용하던 delegate method 호출
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            // 사용자가 위치정보를 사용할 수 있게 허가한 상태라면 requestCurrentLocation 호출
            requestCurrentLocation()
        case .notDetermined, .denied, .restricted:
            // 위치정보 사용을 허가하지 않은 상태인 경우 print로 경고를 출력
            print("not available")
        default:
            print("unknown")
        }
    }
    
    // didUpdateLocations - 새로운 위치정보가 전달되면 반복적으로 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // print(locations.last)
        
        // 배열에 있는 마지막 좌표를 바인딩
        if let location = locations.last {
            currentLocation = location
            updateAddress(from: location)
            // 좌표를 얻은 후 Api 요청을 전달 - 새로운 좌표가 전달되면 속성에 저장하고 Notification을 포스팅
            // weather datasource에서 노티피케이션 옵저버를 추가하고 좌표가 전달되면 Api를 요청하는 방식을 구현
            
        }
    }
    
    // didFailWithError - 에러발생시 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
