//
//  MasterTableViewController.swift
//  XMLParsing
//
//  Created by boreum yoon on 2021/03/04.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    // 태그와 태그 사이의 문자열을 저장할 프로퍼티
    var currentElementValue: String!
    // 하나의 객체를 저장할 임시변수
    var book:Book!
    // 파싱한 결과를 저장할 프로퍼티 (배열)
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Book"
        
        // parsing을 할 때는 데이터의 URL부터 생성
        let url = URL(string: "http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        // XML 파싱 객체 생성
        let xmlParser = XMLParser(contentsOf: url!)
        
        // 파싱을 수행할 메소드 위치 설정
        xmlParser?.delegate = self
        
        // start parsing
        // xmlParser?.parse()
        let result = xmlParser?.parse()
        
        // true, false로 결과 나옴
        // xml데이터 입력이 잘못되었거나, URL 주소를 잘못 썼을 경우에는 false로 나옴
        print(result)
        
    }

    // MARK: - Table view data source

    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 행의 개수 (항상 배열)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    // 셀 생성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text =
            books[indexPath.row].title
        
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MasterTableViewController:XMLParserDelegate {
    // 여는 태그를 만났을 때 호출되는 메소드(didStartElement)
    // qualifiedName - 태그 , attributeDict - 속성
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // 여는 태그는 객체 생성할 때만 작업
        if elementName == "Book" {
            // 하나의 객체를 준비
            book = Book()
            // 속성 전부 가져오기
            let dic = attributeDict as Dictionary
            // id 속성의 값을 bookID에 저장
            book?.bookId = dic["id"]
        }
    }
    
    // 두번째 메소드 잘 이해하기
    // 태그와 태그사이의 문자열을 만났을 때 호출되는 메소드 - foundCharacters
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // 태그 와 태그 사이에서 처음 등장한 경우
        if currentElementValue == nil {
            currentElementValue = string
            
        }
        // 텍스트가 너무 길어서 다시 등장한 경우
        // 태그는 256이상을 작성할 수 없음
        // 태그와 태그 사이의 문자열은 글자 수 제한이 없으므로 연속해서 불러지면 데이터를 추가시켜야함 처음 불러졌을 때는 통으로 대입하면 되지만 그 다음 부터는 추가시켜주어야 함 - 보통 이렇게까지는 드문 경우지만 도서의 서평 같은 경우는 앞 쪽의 데이터가 잘리고 맨 마지막 데이터만 남게됨
        else {
            currentElementValue = "\(currentElementValue!)\(string)"
        }
    }
    // 세번째 메소드 - 닫는 태그를 만났을 때 호출되는 메소드
    // 각각 속성을 저장 (didEndElement)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // 가장 마지막 태그를 만나면 종료
        if elementName == "Books" {
            
            // 안나오면 여기서 로그 찍어보기
            NSLog("\(books)")
            return
        }
        // 하나의 객체가 끝나는 태그인 Book을 만나면 배열에 저장
        if elementName == "Book" {
            books.append(book)
            book = nil
        }
        // 각 태그 안의 속성이 끝나면 그 속성의 값을 저장
        else {
            if elementName == "title" {
                book?.title = currentElementValue
            }
            else if elementName == "author" {
                book?.author = currentElementValue
            }
            else if elementName == "summary" {
                book?.summary = currentElementValue
            }
            currentElementValue = nil
        }
    }
}

