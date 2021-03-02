//
//  ListViewController.swift
//  TableViewUpdate
//
//  Created by boreum yoon on 2021/03/02.
//

import UIKit

class ListViewController: UITableViewController {
    
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Wines"
        
        data.append("코노 쇼비뇽 블랑")
        data.append("투 핸즈 엔젤스 쉬라즈")
        data.append("빌라 욜란다 모스카토 다스티")
        data.append("더 래키 쉬라즈")
        data.append("군트럼 리슬링")
        data.append("푸나무 소비뇽 블랑")
        data.append("쿵푸걸 리슬링")

        // 바 버튼을 생성해서 오른쪽에 배치
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertItem(_:)))
        
        // 네비게이션 바의 왼쪽에 edit 버튼을 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // BarButton이 호출할 메소드
    @objc func insertItem(_ sender:UIBarButtonItem) {
        // 입력받기 위한 대화상자를 생성
        let alert = UIAlertController(title: "Name", message: "insert to wine name", preferredStyle: .alert)
        // 텍스트필드 추가
        alert.addTextField(configurationHandler: {(tf) -> Void in
            tf.placeholder = "Wine Name"
        })
        
        // Button 추가 - 대화상자에는 항상 버튼이 있어야함
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "insert", style: .default, handler: {(action) -> Void in
            // 입력한 내용 가져오기
            let item = alert.textFields?[0].text
            // 입력한 내용이 없으면 리턴
            if item == nil || item?.trimmingCharacters(in: .whitespaces).count == 0 {
                return
            }
            
            // 데이터 삽입
            self.data.append(item!)
            // 테이블 뷰 재출력
            // reloadData - 갱신
            // self.tableView.reloadData()
            
            // 삽입하는 애니메이션 수행
            self.tableView.beginUpdates()
            
            self.tableView.insertRows(at: [IndexPath(row:self.data.count-1, section: 0)], with: .bottom)
            
            self.tableView.endUpdates()
        }))
        
        // 대화상자 출력
        self.present(alert, animated: true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }

    // 셀을 안만들었을 때는 identifier를 임의로 작성하는것이 가능
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        var cell =
            tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel!.text = data[indexPath.row]
        
        return cell!
    }
    
    // edit 버튼을 눌렀을 때 호출되는 메소드로
    // 아이콘을 설정하는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // .delete
        return .none
    }
    
    // 들여쓰기 관련 메소드
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 셀을 이동할 때 호출되는 메소드
    // sourceIndexPath - 선택한 자리 , destinationIndexPath - drop한 자리
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 데이터 이동
        let movedObjet = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(movedObjet, at: destinationIndexPath.row)
    }
    
    // edit 버튼을 누르고 아이콘을 눌렀을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 데이터를 삭제하고 테이블 뷰를 재출력
        data.remove(at:indexPath.row)
        // tableView.reloadData()
        
        self.tableView.beginUpdates()
        
        self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        
        self.tableView.endUpdates()
    }

}
