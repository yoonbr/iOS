//
//  MovieListVC.swift
//  MovieInformation
//
//  Created by boreum yoon on 2021/03/05.
//

import UIKit
import Alamofire
import Nuke

class MovieListVC: UITableViewController {
    
    // 출력하는 데이터가 가장 하단보다 아래 있는지 확인하기 위한 플래그 변수
    var flag = false
    
    // 데이터 파싱을 위한 프로퍼티를 선언
    // 현재 출력 중인 페이지 번호를 저장
    var page = 1
    
    // 데이터 목록을 저장할 프로퍼티
    // lazy가 붙으면 처음 사용할 때 생성 - 지연 생성
    // ={}() - 클로저를 이용한 초기화 작업
    lazy var list : [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    // lazy var list1 : [MovieVO] = [MovieVO]()
    
    // 데이터를 다운로드 받아서 파싱하는 메소드
    func downloadData(){
        // 다운로드 받을 URL url = "http://cyberadam.cafe24.com/movie/list?page=1"
        // page는 1부터 시작
        
        // 다운로드 받을 URL을 생성
        let url = "http://cyberadam.cafe24.com/movie/list?page=\(page)"
        
        // GET 방식으로 가져오는 경우 - 결과가 JSON인 경우
        // 인터넷이나 옛날 교재에는 AF 대신 Alamofire라고 써져있는 경우가 있으므로 주의 (Alamofire 사용하려면 예전 버전을 다운로드 받아야 함)
        let request = AF.request(url, method:.get,
            encoding:JSONEncoding.default, headers: [:])
        
        // 응답을 받으면 호출
        request.responseJSON{
            response in
            // 파싱된 결과는 response.value
            
            // 결과를 Dictionary로 변환 - { 로 시작해서
            if let jsonObject = response.value as? [String:Any]{
                // list 키의 내용을 배열로 변환
                let list = jsonObject["list"] as! NSArray
                
                // 배열의 순회
                for index in 0...(list.count - 1){
                    // 항목 하나를 Dictionary로 변환
                    let item = list[index] as! NSDictionary
                    // 항목 하나를 저장할 객체를 생성
                    var movie = MovieVO()
                    // 각 속성의 값을 대입
                    movie.movieId = ((item["movieid"] as! NSNumber).intValue)
                    movie.title = item["title"] as? String
                    movie.genre = item["genre"] as? String
                    movie.thumbnail = item["thumbnail"] as? String
                    movie.link = item["link"] as? String
                    movie.rating = ((item["rating"] as! NSNumber).doubleValue)
                    
                    // 이미지 가져오기
                    // 이미지가 어디있는지도 알고 있어야 함
                    let url:URL! = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail!)")
                    
                    let imageData = try! Data(contentsOf: url)
                    movie.image = UIImage(data:imageData)
                    
                    // 배열에 삽입
                    // 뒤에 붙는 이유!
                    self.list.append(movie)
                
                    
                }
                
                // 현재 페이지 번호에 따른 refresh control 출력 여부를 설정
                // data 개수 가져오기
                let totalCount = (jsonObject["count"] as! NSNumber).intValue
                // 현재 나에게 있는 개수가 토탈 카운트보다 크거나 같으면 업데이트 할 것 이 없음
                if (self.list.count >= totalCount) {
                    // 숨겨버림
                    self.refreshControl?.isHidden = true
                }

                // 데이터 재출력
                self.tableView.reloadData()
            }
        }
    }
    
    // 사용자 정의 메소드 - 위치는 상관 없고 다른 메소드들과 독립적이어야 함
    // refresh control이 보여질 때 호출되는 메소드
    @objc func handleRequest(_ refreshControl:UIRefreshControl){
        // 페이지 번호 증가
        self.page = self.page + 1
        // 데이터를 다운로드 받는 메소드 호출
        self.downloadData()
        // ** 아래 메소드 꼭 해주기
        // refresh control 숨기기
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "영화 목록"
        
        // 데이터를 가져오는 메소드 호출
        downloadData()
        
        // refresh control 과 이벤트 처리 메소드 연결
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.handleRequest(_:)), for: .valueChanged)

        // color
        self.refreshControl?.tintColor = UIColor.purple
    }
    
    // 섹션의 개수를 설정하는 메소드 (numberOfSections)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 섹션 별 행의 개수를 설정하는 메소드 (numberOfRowsInSection)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    // 셀의 모양을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table View cell 의 identifier 이름 알고있어야 함
        // 행 번호에 해당하는 데이터 찾아오기
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.lblTitle.text = row.title
        cell.lblGenre.text = row.genre
        cell.lblRating.text = "\(row.rating!)"
        // cell.thumbnail.image = row.image
        
        // Nuke 라이브러리를 이용해서 이미지 출력
        // 메인 스레드에서 작업하도록 설정
        DispatchQueue.main.async(execute: {
            // 이미지를 다운로드 받을 URL 생성
            let url : URL! =
                URL(string:"http://cyberadam.cafe24.com/movieimage/\(row.thumbnail!)")
            // 옵션 설정
            let options = ImageLoadingOptions(placeholder: UIImage(named:"placeholder"), transition: .fadeIn(duration: 2)
            )
            Nuke.loadImage(with: url, options: options, into: cell.thumbnail)
        })
        
        return cell
    }

    // 셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 셀이 출력될 때 호출되는 메소드
    // 가장 마지막 셀이 보여지면 flag를 true로 만들어줌
    // 가장 하단에서 스크롤 하면 데이터를 불러와서 하단에 출력
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(flag == false && indexPath.row == self.list.count - 1) {
            flag = true
        } else if (flag == true && indexPath.row == self.list.count - 1){
            self.page = self.page + 1
            downloadData()
        }
    }
    
    // 셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 하위 뷰 컨트롤러 객체를 생성
        let movieDetailVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailVC") as! MovieDetailVC
        
        // 넘겨줄 데이터를 생성
        movieDetailVC.link = list[indexPath.row].link
        
        // 타이틀 설정
        movieDetailVC.title = list[indexPath.row].title
        
        // 하위 뷰 컨트롤러 출력
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
