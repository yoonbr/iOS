//
//  MemoListTableViewController.swift
//  MyMemo
//
//  Created by boreum yoon on 2021/04/26.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    // 새로운 속성 추가 - closure 활용하여 초기화
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "ko_kr")
        return f
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reloadData - datasource가 전달해주는 최신 데이터로 업데이트
        // tableView.reloadData()
        
        // 실제 업데이트 되었는지 확인하는 로그 추가
        // print(#function)
        
        // 배열이 데이터로 채워짐
        DataManager.shared.fetchMemo()
        // 배열에 저장된 데이터를 기반으로 테이블 뷰가 업데이트 
        tableView.reloadData()
    }
    
    // 토큰 저장 속성 추가
    var token: NSObjectProtocol?
    
    // 소멸자에서 해제
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    // 새 메소드 추가
    // prepare - 세그웨이가 연결된 화면을 생성하고 화면 전환 직전에 호출
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.memo = DataManager.shared.memoList[indexPath.row]
            }
        }
    }
    
    // 주로 한번만 실행하는 초기화 코드를 여기서 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        // 옵저버 추가
        // UI 업데이트 코드는 반드시 메인스레드에서 실행해야 함
        // iOS는 스레드를 직접 처리하지 않고 Dispatchqueue, OperationQueue 사용
        // Notification에서 가장 중요한 것은 Observer 해제
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    // 테이블 뷰 출력할 개수 지정 (필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 더미데이터 개수 출력
        return DataManager.shared.memoList.count
    }

    // 중요 메소드 (필수)
    // 개별 셀을 호출할 때 마다 반복적으로 표현
    // indexPath : 목록 내에서 특정 셀 위치를 표현
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // cell 이라는 상수에 메인스토리보드에서 구상했던 프로토타입 셀이 생성되어 저장됨
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // row 속성을 통해서 표시할 데이터를 가져옴
        let target = DataManager.shared.memoList[indexPath.row]
        // subtitle
        cell.textLabel?.text = target.content
        // fomatter에서 string from insertdate 호출
        cell.detailTextLabel?.text = formatter.string(for: target.insertDate)
        
        // lable text color 변경
        if #available(iOS 11.0, *) {
            cell.detailTextLabel?.textColor = UIColor(named: "NoteColor")
        } else {
            cell.detailTextLabel?.textColor = UIColor.lightGray
        }
        
        // 이 메소드에서 셀을 가져온 다음 실제 데이터를 채워 return
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        // 편집기능 활성화
        return true
    }
    
    // 편집 스타일 지정
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // 원하는 편집 스타일 리턴
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 메모 삭제 코드 구현
            // 삭제할 메모를 상수에 저장
            let target = DataManager.shared.memoList[indexPath.row]
            // deleteMemo 호출 후 파라미터로 target 지정 
            DataManager.shared.deleteMemo(target)
            
            // 배열에서도 삭제 필수
            DataManager.shared.memoList.remove(at: indexPath.row)
            
            // tabelView에서 셀을 삭제하는 코드가 구현되어있음
            // 테이블 뷰의 셀 숫자와 배열에 저장되어있는 데이터 숫자가 달라져서 크래쉬 발생
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


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
