//
//  WineNoteDataSource.swift
//  winenote
//
//  Created by boreum yoon on 2021/05/13.
//

import Foundation

// 싱글톤 클래스 구현
class WineNoteDataSource {
    // 하나의 인스턴스를 싱글톤으로 공유하도록 구현
    static let shared = WineNoteDataSource()
    private init() { }
    
    // 필요 속성 추가
    
    // 와인 리스트 저장
    var winelist: WineList?
    // 노트 리스트 저장
    var notelist = [NoteListData]()
    // api 요청시 사용할 Dispatchqueue
    // component 옵션을 추가하여 최대한 많은 작업을 동시에 처리
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    // DispatchGroup : 두개의 Api 요청을 하나의 논리적인 그룹으로 묶어줄 때 사용
    let group = DispatchGroup()
    
    // 외부에서 호출하는 메소드 추가
    func fetch(winenum: Int, completion: @escaping () -> ()) {
        group.enter()
        apiQueue.async {
            self.fetchNoteList(winenum: winenum) { (result) in
                switch result {
                case .success(let data):
                    self.notelist = data.list.map {
                        let nickname = $0.nickname ?? "알 수 없음"
                        let price = $0.price ?? 0
                        let firstword = $0.firstword ?? "null"
                        let secondword = $0.secondword ?? "null"
                        let notedate = $0.notedate ?? "0000-00-00"
                        
                        return NoteListData(nickname: nickname, notedate: notedate, price: price, firstword: firstword, secondword: secondword)
                    }
                default:
                    self.notelist = []
                }
                self.group.leave()
            }
        }
        group.enter()
        apiQueue.async {
            self.fetchWineList(winenum: winenum) { (result) in
                switch result {
                case .success(let data):
                    self.winelist = data
                default:
                    self.winelist = nil
                }
                self.group.leave()
            }
        }
        
        // 모든 작업이 끝날때 까지 대기
        group.notify(queue: .main) {
            completion()
        }
    }
}

extension WineNoteDataSource {
    // 범용적 사용 가능한 fetch 함수
    // 다른 타입에서도 사용할 수 있게 Generic
    // Type Parameter : ParsingType, codable 채용한형식
    // 클로저를 전달하는 파라미터도 추가, 결과를 받을 때는 result type
    
    // 외부에서 호출되면 안되므로 private
    private func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()){
        
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
    // 외부에서 호출되면 안되므로 private
    private func fetchNoteList(winenum: Int, completion: @escaping (Result<NoteList, Error>) -> ()) {
        let urlStr = "http://localhost/note/notelist/\(winenum)"
        
        fetch(urlStr: urlStr, completion: completion)
    }
    
    // completion parameter, fetch 함수 추가
    private func fetchWineList(winenum: Int, completion: @escaping (Result<WineList, Error>) -> ()) {
        let urlStr = "http://localhost/wine/detail/\(winenum)"
        
        fetch(urlStr: urlStr, completion: completion)
    }
}

