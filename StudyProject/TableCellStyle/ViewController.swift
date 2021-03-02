//
//  ViewController.swift
//  TableCellStyle
//
//  Created by boreum yoon on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {
    // 출력할 데이터 배열
    var ar = [String]()
    
    // 2. 출력할 이미지 파일 이름이 동일하지 않으면 사용
    var imageNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ar.append("jerry0")
        ar.append("jerry1")
        ar.append("jerry2")
        ar.append("jerry3")
        ar.append("jerry4")
        ar.append("jerry5")
        
        // 2-1. 이미지 파일 이름 직접 입력
        imageNames.append("jerry0.jpg")
        imageNames.append("jerry1.jpg")
        imageNames.append("jerry2.jpg")
        imageNames.append("jerry3.jpg")
        imageNames.append("jerry4.jpg")
        imageNames.append("jerry5.jpg")
    }


}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    // 섹션(그룹)의 개수를 설정하는 메소드 - 구현하지 않으면 1을 리턴
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 섹션 별 행의 개수를 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ar.count
    }
    
    // 셀을 만들어주는 메소드 - 필수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        // 텍스트를 출력
        cell!.textLabel!.text = ar[indexPath.row]
        
        // 이미지를 출력 **자신의 그림파일 이름과 동일해야함
        cell!.imageView!.image = UIImage(named: "jerry\(indexPath.row + 0).jpg")
        
        // 보조 텍스트를 출력
        // style이 default면 deatiltext는 적용이 되지않음
        cell!.detailTextLabel?.text = "jerrys"
        
        
        
        // 2-2. 항상 행번호라는 것을 잊어버리지 말기!
        // cell!.imageView!.image = UIImage(named: imageNames[indexPath.row])
        
        return cell!
    }
}


