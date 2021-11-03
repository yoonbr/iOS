//
//  MainController.swift
//  day_10
//
//  Created by boreum yoon on 2021/11/01.
//

import UIKit

// 1. let로 하면 X - 내용을 추가하거나 제거할 수 있으므로
// 전역변수로 사용 
var txtArr = ["도서구매", "친구 만나기", "스터디"]
var imgArr = [UIImage(named: "0.png"),
              UIImage(named: "1.png"),
              UIImage(named: "2.png")]

class MainController: UITableViewController {
    
    
    @IBOutlet var tvList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 편집 버튼을 왼쪽으로 이동 - 기존 오른쪽으로 위치되어있음
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source
    // 칸 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 행 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return txtArr.count
    }

    // 각 행의 정보
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // withIdentifier = myCell
        // Cell에 지정한 이름을 넣어줘야 해당되는 셀이 작동됨
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // 1-1. 배열 선언 후 수정 - 배열 입력
        cell.textLabel?.text = txtArr[indexPath.row]
        // 1-2. imageArr 추가
        cell.imageView?.image = imgArr[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // 4. 삭제 기능 추가
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 4-1. 삭제 실행되는지 확인
            print("delete cell", indexPath.row)
            // 4-2. 텍스트, 이미지 삭제하기
            txtArr.remove(at: indexPath.row)
            imgArr.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    // 5. 목록 이동 (파라미터 확인)
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 5-1. 이동할 번호 가져오기 (old, new)
        let oldNum = fromIndexPath.row
        let newNum = to.row
        
        // 5-2. 기존 데이터 미리 뺄 번호를 저장
        let txtData = txtArr[oldNum]
        let imgData = imgArr[oldNum]
        
        // 5-3. 목록, 이미지 배열에서 삭제
        txtArr.remove(at: oldNum)
        imgArr.remove(at: oldNum)
        
        // 5-4. 새로운 번호에 추가
        txtArr.insert(txtData, at: newNum)
        imgArr.insert(imgData, at: newNum)
    }
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // identifier 알아보는 테스트 
        print(segue.identifier)
        // 2. detailController 데이터 받기 - destination 선언
        if segue.identifier == "sgDetail" {
            let detailCon = segue.destination as! DetailController
            
            // 2-3. 선택한 셀 확인
            let selCell = sender as! UITableViewCell
            
            // 2-4. 선택한 셀이 누군지 확인
            // let pp = tvList.indexPath(for: selCell) // ([컬럼, row])
            
            let no = tvList.indexPath(for: selCell)?.row // ([row])
            
            // print(no)
            
            // 2-1. detailCon에서 detailController에 있는 LB에 텍스트 추가
            // no로 선택한 셀 확인 후 넘기기 
            detailCon.detailLbNum = no!
            
        }
    }
    
    // 3-4. 목록 띄우기
    override func viewWillAppear(_ animated: Bool) {
        print("run viewWillAppear")

        tvList.reloadData() // 테이블 뷰 데이터 다시 로드 
    }
}
