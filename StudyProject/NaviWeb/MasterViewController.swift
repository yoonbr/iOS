//
//  MasterViewController.swift
//  NaviWeb
//
//  Created by boreum yoon on 2021/03/03.
//

import UIKit

class MasterViewController: UITableViewController {
    // 이미지 이름, 이름, URL을 저장하기 위한 배열
    // 연관된 데이터는 무조건 하나로 묶어야 함
    var attractionImgs = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    // 가장 하단의 셀이 가장 마지막 데이터인지 확인 할 변수
    var flag = false
    
    // RefreshControl 이 보여질 때 호출되는 메소드
    @objc func handleRequest(_ refreshControl: UIRefreshControl) {
        
        // 이름 추가
        attractionNames.insert("엔젤스 쉐어", at: 0)
        attractionNames.insert("코노", at: 0)
        
        // URL 추가
        webAddresses.insert("http://www.naver.com", at: 0)
        webAddresses.insert("http://www.naver.com", at: 0)
        
        // 이미지 추가
        attractionImgs.insert("wine1.png", at: 0)
        attractionImgs.insert("wine2.png", at: 0)

        // 딜레이 강제 발생 - 원래 할 필요 없음
        // sleep(5)
        
        // refreshControl 중지
        refreshControl.endRefreshing()
        
        // 삽입하는 애니메이션을 추가
        let ar = [IndexPath(row: 0, section: 0),IndexPath(row: 1, section: 0)]
        tableView.beginUpdates()
        tableView.insertRows(at: ar, with: .top)
        tableView.endUpdates()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 데이터 초기화
        attractionImgs = ["wineBar.png", "wineShop.png"]
        attractionNames = ["와인바 검색", "와인샵 검색"]
        webAddresses = ["http://localhost:9300/map", "http://kko.to/E4SIURADo"]
        
        self.title = "search"
        
        // RefreshControl 배치
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRequest(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        
        // 운영체제 버전이 10.0 이상이라면
        // 10.0 이상에서
        if #available(iOS 10.0, *){
            tableView.refreshControl =
                refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    // MARK: - Table view data source
    
    // 섹션(Group)의 개수를 설정하는 메소드
    // 구현하지 않으면 1을 리턴한 것으로 간주
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        let cellIdentifier = "AttractionTableViewCell"
        
        // 행 번호 찾아오기(indexPath.row)
        let row = indexPath.row
        
        // 셀 생성
        // 자신의 셀을 사용하기 위해 강제 형 변환 (as! AttractionTableViewCell)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AttractionTableViewCell
        
        // 데이터 출력
        cell.Attractionlbl.text = attractionNames[row]
        cell.AttractionImg.image = UIImage(named: attractionImgs[row])
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
        let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        // 데이터 넘겨주기
        detailViewController.name = attractionNames[indexPath.row]
        detailViewController.url = webAddresses[indexPath.row]
        
        // 화면에 출력
        navigationController?.pushViewController(detailViewController, animated: true)
     }
    
    // 셀이 보여질 때 호출되는 메소드
    // 가장 마지막 셀이 출력되면 데이터를 추가
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(flag == false && indexPath.row == self.attractionImgs.count - 1){
            flag = true
        }else if(flag == true && indexPath.row == self.attractionImgs.count - 1){
            
            // 데이터 추가 후 재출력
            attractionNames.append("푸나무")
            attractionNames.append("수수마니엘로")
  
            webAddresses.append("http://www.naver.com")
            webAddresses.append("http://www.naver.com")

            attractionImgs.append("wine4.png")
            attractionImgs.append("wine5.png")
            
            tableView.reloadData()
        }
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
