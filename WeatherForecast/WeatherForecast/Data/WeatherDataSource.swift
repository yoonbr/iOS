//
//  WeatherDataSource.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/19.
//

import Foundation
import CoreLocation

// 1. CoreLocation import 후에 Sington class 추가
// 하나의 인스턴스를 싱글톤으로 공유하도록 구현
class WeatherDataSource {
    static let shared = WeatherDataSource()
    private init() { }
    
    // 4. 클래스 선언 부분에 필요한 속성 추가
    var summary: CurrentWeather?
    var forecast: Forecast?
    
    // api를 요청할 때 사용할 dispatchQueue
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    
    // DispatchGroup : 두 개의 api 요청을 하나의 논리적인 그룹으로 묶을 때 사용
    let group = DispatchGroup()
    
    // 5. 외부에서 호출하는 메소드 추가 (좌표 버전만 추가)
    // api를 요청하기 전 group에서 enter 메소드를 호출 -> 클로저에서 작업 요청 -> 작업끝난 후 리브 메소드 호출
    // enter와 leave의 짝을 맞춰야함
    // 엔터가 두번 호출되었으므로 그룹이라는 하나의 논리적인 작업단위에 두개의 작업이 추가됨.
    func fetch(location: CLLocation, completion: @escaping () -> ()) {
        group.enter()
        apiQueue.async {
            self.fetchCurrentWeather(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.summary = data
                default:
                    self.summary = nil
                }
                
                self.group.leave()
            }
        }
        
        group.enter()
        apiQueue.async {
            self.fetchForecast(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.forecast = data
                default:
                    self.forecast = nil
                }
                
                self.group.leave()
            }
        }
        // notify - 그룹에 포함된 모든 작업이 끝날때 까지 대기 -> 끝나는 시점은 모든 작업이 leave를 호출 할 때
        // 모든 작업이 끝나면 파라미터로 지정한 queue 에서 두번째 파라미터로 전달한 closure를 호출
        group.notify(queue: .main) {
            // fetch 메소드로 전달된 closure를 다시 호출
            completion()
        }
    }
}

// 2. 새 익스텐션 추가 후 fetch 메소드를 붙여넣기
// 외부에서 호출되면 안되므로 private
// 클래스에 바로 붙여넣어도 되지만 Api 종류에 따라 코드를 구분하기 위해서 별도의 익스텐션으로 붙여넣음
// 동일한 파일에서 익스텐션으로 분리도 가능하고 별도의 파일로 분리도 가능
private extension WeatherDataSource {
    func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
        
        // 오류가 발생하면 여기서 코드가 멈추고 메시지가 출력
        // fatalError는 바로 crash가 발생하기 때문에 앱스토어에 출시하는 어플에는 사용하면 안됨
        guard let url = URL(string: urlStr) else {
            // fatalError("URL 생성 실패")
            completion(.failure(ApiError.invalidUrl(urlStr)))
            return
        }
        
        // url로 요청을 전달하고 요청이 오면 클로저가 호출
        // task 생성 후에는 반드시 resume 호출해야 실제로 요청이 전달됨
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            // 먼저 error parameter 확인
            // error parameter가 nil이 아니라면 error를 출력하고 closure를 종료
            // 위치를 쉽게 찾기 위해 fatalError 선언
            if let error = error {
                // fatalError(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            // reponse parameter를 httpResponse로 type casting
            // typecasting 할 수 없을 때 fatalError로 종료
            guard let httpResponse = response as? HTTPURLResponse else {
                // fatalError("invalid response")
                completion(.failure(ApiError.invalidResponse))
                return
            }
            
            // typecasting 성공시 코드가 200인지 확인, 아니면 fatalError로 종료
            // 코드가 여기까지 실행되면 정상적인 응답
            guard httpResponse.statusCode == 200 else {
                // fatalError("failed code \(httpResponse.statusCode)")
                completion(.failure(ApiError.failed(httpResponse.statusCode)))
                return
            }
            
            // 첫번째 파라미터의 data가 optional이므로
            // optional binding 을 활용하여 unwrapping
            guard let data = data else {
                // fatalError("empty data")
                completion(.failure(ApiError.emptyData))
                return
            }
            
            // JSONDecoder 생성 후 서버에서 전달된 데이터를 파싱
            do {
                let decoder = JSONDecoder()
                // 데이터의 타입을 파라미터로 전달, 바인딩 된 데이터를 그대로 전달
                // ParsingType으로 바꾸고 상수의 이름도 일반적인 이름으로 수정
                let data = try decoder.decode(ParsingType.self, from: data)
                
                // 성공시 파싱된 데이터를 전달
                completion(.success(data))
                
            } catch {
                completion(.failure(error))
                // print(error)
                // fatalError(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    // API URL 복사 후 새로운 함수 추가후 key의 value를 parameter로 대체
    // completion 파라미터 추가
    // apikey 수정
    private func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric&lang=kr"
        
        // fetch 함수 호출
        fetch(urlStr: urlStr, completion: completion)
        
    }

    private func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr"
        
        // fetch 함수 호출
        fetch(urlStr: urlStr, completion: completion)
        
    }

    private func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric&lang=kr"
        
        // fetch 함수 호출
        fetch(urlStr: urlStr, completion: completion)
        
    }
}

// 3. forecast의 함수도 가져와서 붙여넣기, private 추가 
extension WeatherDataSource {
    private func fetchForecast(cityName: String, completion: @escaping (Result<Forecast, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&units=metric&lang=kr"
        
        // fetch 함수 호출
        fetch(urlStr: urlStr, completion: completion)
        
    }

    private func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr"
        
        // fetch 함수 호출
        fetch(urlStr: urlStr, completion: completion)
        
    }

    private func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric&lang=kr"
        
        // fetch 함수 호출
        fetch(urlStr: urlStr, completion: completion)
        
    }
}
