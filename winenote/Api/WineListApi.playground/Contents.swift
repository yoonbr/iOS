import UIKit

struct WineList: Codable {

    struct List: Codable {
        let winenum: Int
        let price: Int
        let wineimg: String
        let winename: String
    }
    
    let list: [List]
}
// 에러형식 선언
// error protocol을 채용한 열거형으로 선언
enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

// 범용적 사용 가능한 fetch 함수
// 다른 타입에서도 사용할 수 있게 Generic
// Type Parameter : ParsingType, codable 채용한형식
// 클로저를 전달하는 파라미터도 추가, 결과를 받을 때는 result type
func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()){
    
    // 공통적으로 사용
    guard let url = URL(string: urlStr) else {
        // fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        // error parameter 확인
        if let error = error {
            // fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }
        
        // response -> HTTPURLresponse
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
        
        guard let data = data else {
            // fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            // decoder가 제공하는 decode 메소드로 json parsing
            let data = try decoder.decode(ParsingType.self, from: data)
            
            // 성공하면 파싱된 데이터를 전달
            completion(.success(data))
            
        } catch {
            // print(error)
            // fatalError(error.localizedDescription)
            completion(.failure(error))
        }
    }
    task.resume()
}

// completion parameter, fetch 함수 추가
func fetchWineList(completion: @escaping (Result<WineList, Error>) -> ()) {
    let urlStr = "http://localhost/wine/all"
    
    fetch(urlStr: urlStr, completion: completion)
}

fetchWineList() { _ in }
