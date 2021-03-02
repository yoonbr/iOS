//
//  ListViewController.swift
//  CellCustom
//
//  Created by boreum yoon on 2021/03/02.
//

import UIKit

class ListViewController: UITableViewController {
    
    var ar : Array<Dictionary<String, String>> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let dic1 = ["name":"Two Hands Angels Share Shiraz", "price":"38000", "score":"4.5", "imageName":"wine1.png"]
        let dic2 = ["name":"KONO SAUVIGNON BLANC", "price":"27000", "score":"4.8", "imageName":"wine2.png"]
        let dic3 = ["name":"Villa Jolanda Moscato dAsti", "price":"29000", "score":"4.2", "imageName":"wine3.png"]
        
        // 다시 배열로 묶기
        ar = [dic1, dic2, dic3]
        self.title = "Wine"
    }
    
    // numberOfSections - 섹션의 개수
    // 섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        // numberOfSections - 섹션의 개수
       
        return 1
    }
    // 섹션 별 행의 개수를 설정하는 메소드 - 필수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ar.count
    }

    // 셀의 모양을 설정하는 메소드 - 필수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀의 identifier
        // 스토리보드에 설정한 이름
        let cellIdentifier = "CustomCell"
        
        // 재사용 가능한 셀 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomCell

        // 출력할 데이터 가져오기
        let dic = ar[indexPath.row]
        
        cell!.lblName!.text = dic["name"]
        cell!.lblPrice!.text = dic["price"]
        cell!.lblScore!.text = dic["score"]
        cell!.imageView!.image = UIImage(named: dic["imageName"]!)
        
        return cell!
    }
    
    // 셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
