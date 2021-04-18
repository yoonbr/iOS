import UIKit

// JSON과 동일한 구조를 가진 구조체 생성
// 해당 구조체 안에 구조체를 생성할 때는 api 동일한 key 값으로 설정해주는 것이 좋음
struct CurrentWeather: Codable {
    let dt: Int
    
    // 구조체를 하나 만든 다음 속성을 추가
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
        
    }
    
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
    guard let url = URL(string: urlStr) else {
        // fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }
    
    // task 생성 후에는 반드시 resume 호출
    let task = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        
        // error parameter 확인
        if let error = error {
            // fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }
        // reponse parameter
        guard let httpResponse = response as? HTTPURLResponse else {
            // fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }
        
        guard httpResponse.statusCode == 200 else {
            // fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }
        
        // optional binding 을 활용하여 unwrapping
        
        guard let data = data else {
            // fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
            
            /*
            weather.weather.first?.description
            
            // 현재 기온 표시
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

func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
    let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=9b9cc574b4b3db755c117eb100c67f56&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
    // 오류가 발생하면 여기서 코드가 멈추고 메시지가 출력
    // fatalError는 바로 crash가 나기 때문에 앱스토어에 등록되는 어플에는 사용하면 안됨
    
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
