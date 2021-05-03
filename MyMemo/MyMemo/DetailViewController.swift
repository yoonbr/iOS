//
//  DetailViewController.swift
//  MyMemo
//
//  Created by boreum yoon on 2021/04/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    
    // 이전화면에서 전달한 메모를 저장할 속성 추가
    // 초기화 되는 시점에는 값이 없기때문에 optional로 선언
    var memo: Memo?
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "ko_kr")
        return f
    }()
    
    // 메모 삭제 구현
    @IBAction func deleteMemo(_ sender: Any) {
        // UIAlertController 생성
        let alert = UIAlertController(title: "delete check", message: "메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        // destructive - red color text
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            // 현재 화면에 표시되어 있는 메모를 파라미터로 전달
            DataManager.shared.deleteMemo(self?.memo)
            
            // 메모를 삭제 한 후 이전화면으로 돌아가기 - 네비게이션 컨트롤러에 접근한 후 pop
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        
        // handler 직접 구현하지 않고 nil 전달
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        // 경고창 화면에 표시 
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // 속성 추가
    // 네비게이션 컨트롤러가 관리하는 첫번째 뷰 컨트롤러로 메모를 전달 - 컴포즈 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = memo
        }
    }
    
    // Notification Token 저장
    var token: NSObjectProtocol?
    
    // 옵저버 해제
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 옵저버 추가 
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in self?.memoTableView.reloadData()
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// 1. DetailViewController 클래스가 UITableView DataSource protocol을 채용한다고 선언
extension DetailViewController: UITableViewDataSource {
    // fix
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            // 목록화면에서 전달한 메모를 보기화면에 표시
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            
            return cell
            
        default:
            fatalError()
        }
    }
    
    
}
