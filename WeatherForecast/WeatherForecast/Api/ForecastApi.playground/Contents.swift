import UIKit
import CoreLocation

// 1. JSON구조와 동일한 구조체 생성
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

// 2. ForecastApi에서 코드 가져온 후 함수의 이름 수정
// error 형식 선언
// swift에서 error형식을 선언할 때는 대부분 error protocol을 채용한 열거형으로 선언
enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

// guard에서 resume 까지는 공통적으로 사용되기 때문에 별도의 함수로 추출
// 이 함수를 다른 type에도 사용할 수 있도록 generic으로 수정 - type parameter는 parsingtype, codable을 채용
// closure를 전달하는 parameter도 추가, 결과를 받을 때는 Result type
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
// 함수의 이름과 컴플리션 타입의 이름, URL 바꾸기 - option + cmd + f
func fetchForecast(cityName: String, completion: @escaping (Result<Forecast, Error>) -> ()) {
    let urlStr = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=9b9cc574b4b3db755c117eb100c67f56&units=metric&lang=kr"
    
    // fetch 함수 호출
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast, Error>) -> ()) {
    let urlStr = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=9b9cc574b4b3db755c117eb100c67f56&units=metric&lang=kr"
    
    // fetch 함수 호출
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast, Error>) -> ()) {
    let urlStr = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=9b9cc574b4b3db755c117eb100c67f56&units=metric&lang=kr"
    
    // fetch 함수 호출
    fetch(urlStr: urlStr, completion: completion)
    
}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
fetchForecast(location: location) { (result) in
        switch result {
        case .success(let weather):
            dump(weather)
        case .failure(let error):
            print(error)
        }
    }

// 빈 closure 생성
//fetchForecast(cityName: "seoul") { _ in }
//
//fetchForecast(cityId: 1835847) { (result) in
//    switch result {
//    case .success(let weather):
//        dump(weather)
//    case .failure(let error):
//        print(error)
//    }
//}
