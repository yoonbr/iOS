import UIKit

struct NoteList: Codable {

    struct List: Codable {
        let notenum: Int
        let winenum: Int
        let nickname: String
        let notedate: String
        let price: Int
        let firstword: String
        let secondword: String
        let wineimg: String
        let winename: String
    }
    
    let list: [List]
}

func fetchNoteList(winenum: Int) {
    let urlStr = "http://localhost/note/notelist/\(winenum)"
    
    guard let url = URL(string: urlStr) else {
        fatalError("URL 생성 실패")
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        // error parameter 확인
        if let error = error {
            fatalError(error.localizedDescription)
            return
        }
        
        // response -> HTTPURLresponse
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            fatalError("failed code \(httpResponse.statusCode)")
        }
        
        guard let data = data else {
            fatalError("empty data")
        }
        
        do {
            let decoder = JSONDecoder()
            // decoder가 제공하는 decode 메소드로 json parsing
            let notes = try decoder.decode(NoteList.self, from: data)
            
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    task.resume()
}

fetchNoteList(winenum: 1)
