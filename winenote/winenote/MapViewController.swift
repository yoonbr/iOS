//
//  MapViewController.swift
//  winenote
//
//  Created by boreum yoon on 2021/03/16.
//

import UIKit

class MapViewController: UITableViewController {
    
        // 이미지 이름, 이름, URL을 저장하기 위한 배열
        // 연관된 데이터는 무조건 하나로 묶어야 함
        var attractionImgs = [String]()
        var attractionNames = [String]()
        var webAddresses = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 초기화
        attractionImgs = ["wineBar.png", "wineShop.png"]
        attractionNames = ["와인바 검색", "와인샵 검색"]
        // webAddresses = ["http://kko.to/pLchULeDM", "http://kko.to/E4SIURADo"]
        
        self.title = "wine map"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 위의 메소드에서 2이상 리턴하면 섹션의 헤더나 푸터를 구현하는 메소드가 같이 구현되는 경우가 많음
    // 그룹을 나누면 그룹을 구분해주어야 하기 때문에 섹션의 헤더나 푸터를 구현해주어야 함

    // 섹션 별로 행의 개수를 설정하는 메소드
    // 섹션이 2개 이상이면 section의 매개변수에 index(일련번호)가 전달되므로
    // 인덱스를 이용해서 섹션 별로 행의 개수를 설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 상단에 만든 데이터.count 로 생성해도 되지만 배열의 개수가 다를 수 있으므로 출력된 데이터가 정확하지 않을 수 있음
        // 데이터를 설계할 때는 따로따로 만들지 말고 하나의 배열로 만드는 것이 좋음
        
        return attractionNames.count
    }

        // 각 행에 해당하는 셀을 만들어주는 메소드
        // IndexPath - 각 셀의 섹션 번호와 행 번호를 가지고 있음
        // 섹션이나 행에 따라 다르게 출력하고자 할 때 이용 (데이터를 찾아올 때도 이용)
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // cell 생성 가장 기본적인 방법 - 출력할 셀의 identifier 생성
            let cellIdentifier = "AttractionTVC"
            
            // 행 번호 찾아오기(indexPath.row)
            let row = indexPath.row
            
            // 셀 생성
            // 자신의 셀을 사용하기 위해 강제 형 변환 (as! AttractionTableViewCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AttractionTVC
            
            // 데이터 출력
            cell.lblMap.text = attractionNames[row]
            cell.mapImage.image = UIImage(named: attractionImgs[row])
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
        
        // cell의 높이(100)를 설정하는 메소드
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        // 셀을 선택했을 때 호출되는 메소드(didSelectRowAt)
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            // 하위 뷰 컨트롤러 객체 만들기
            let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailVC") as! DetailVC
            
            // 데이터 넘겨주기
            detailViewController.name = attractionNames[indexPath.row]
            detailViewController.url = webAddresses[indexPath.row]
            
            // 화면에 출력
            navigationController?.pushViewController(detailViewController, animated: true)
         }
}
