//
//  MovieListVC.swift
//  MovieInformation
//
//  Created by boreum yoon on 2021/03/05.
//

import UIKit

class MovieListVC: UITableViewController {
    
    func getThumbnailImage(_ index:Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열에서 데이터를 읽어옴
        var movie = self.list[index]
        
        // 저장된 이미지가 있으면 그것을 반환하고 없을 경우 내려받아 저장한 후 반환
        if let savedImage = movie.image {
            return savedImage
        } else {
            let url: URL! = URL(string: movie.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            movie.image = UIImage(data: imageData)
            return movie.image!
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // 현재 페이지 값에 1을 추가
        self.page += self.page + 1
        
        self.downloadData()
        
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MOVIE LIST"
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(MovieListVC.handleRefresh(_:)), for: .valueChanged)
        self.refreshControl!.tintColor = UIColor.red
        self.downloadData()
        
        // 다운로드 받을 URL
        let url = "http://cyberadam.cafe24.com/movie/list"
        let apiURI : URL! = URL(string: url)
        
        // REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 데이터 전송 결과 로그로 출력
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\(log)")
        
        do{
            // JSON 객체를 파싱하여 NSDictionary 객체로 받음
        let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as!
            NSDictionary
            
            // 데이터 구조에 따라 차례대로 캐스팅하며 읽어옴
            let movies = apiDictionary["list"] as! NSArray
            
            // lterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장
            for row in movies{
                // 데이터를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                // 테이블 뷰 리스트를 구성할 데이터 형식
                var movie = MovieVO()
                
                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                movie.title = r["title"] as? String
                movie.genre = r["genre"] as? String
                movie.thumbnail = r["thumbnail"] as? String
                movie.link = r["link"] as? String
                movie.rating = ((r["rating"] as! NSNumber).doubleValue)
                
                // 웹상에 있는 이미지를 읽어와 UIImage 객체로 생성
                let url: URL! = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail!)")
                let imageData = try! Data(contentsOf: url)
                movie.image = UIImage(data:imageData)
                
                // list 배열에 추가
                self.list.append(movie)
                NSLog(self.list.description)
            }
            
            // 데이터를 다시 읽어오도록 테이블 뷰를 갱신
            self.tableView.reloadData()
            
            // 전체 데이터 카운트 얻기
            let totalCount = (apiDictionary["count"] as? NSNumber)!.intValue
            
            // totalCount가 읽어온 데이터 크기와 같거나 클 경우 리프레시 컨트롤을 숨김
            if(self.list.count >= totalCount) {
                self.refreshControl?.isHidden = true
            }
        } catch {
            NSLog("Parse Error!!")
        }
        
    }
    
    // 페이지 번호를 저장할 변수 선언
    var page = 1
    
    // 데이터를 다운로드 받는 메소드 생성
    func downloadData(){
        // 다운로드 받을 URL 만들기
        let url = "http://cyberadam.cafe24.com/movie/list?page=\(page)"
        let apiURI : URL! = URL(string: url)
        
        // REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 데이터 전송 결과를 로그로 출력
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\(log)")
    }
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    // 섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    // 섹션 별 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }

    // 셀을 만들어서 출력하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스 읽어오기
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.lblTitle?.text = row.title
        cell.lblStory?.text = row.genre
        cell.lblScore?.text = "\(row.rating!)"
        DispatchQueue.main.async(execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        }) 
        return cell
    }
    
    // 셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번 째 행입니다.")
    }
    
    // 셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
