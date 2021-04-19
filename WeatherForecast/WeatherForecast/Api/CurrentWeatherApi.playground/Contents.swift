import UIKit

// 1. JSON과 동일한 구조를 가진 구조체 생성 - JSON decoder
// 해당 구조체 안에 구조체를 생성할 때는 apikety와 동일한 key 값으로 설정해주는 것이 좋음

// decodable과 incodable이 하나로 합쳐진 codable을 채용
// 안에 있는 모든 type에도 codable을 채용하도록 선언을 추가
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

// error 형식 선언
enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

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
            let weather = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(weather))
            
            /*
            // 인스턴스의이름.weather키 접근.첫번째요소 접근.description에 접근
            weather.weather.first?.description
            
            // 현재 기온 표시
            // 인스턴스이름.mainkey접근.tempkey접근
            weather.main.temp
            */
            
        } catch {
            completion(.failure(error))
            // print(error)
            // fatalError(error.localizedDescription)
        }
    }
    
    task.resume()
}

// 2. API URL 복사 후 새로운 함수 추가후 key의 value를 parameter로 대체
func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
    let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=9b9cc574b4b3db755c117eb100c67f56&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
    let urlStr = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=9b9cc574b4b3db755c117eb100c67f56&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

fetchCurrentWeather(cityName: "seoul") { _ in }

fetchCurrentWeather(cityId: 1835847) { (result) in
    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}
