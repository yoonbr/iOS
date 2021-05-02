//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by boreum yoon on 2021/04/27.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // 새로운 속성 추가 - 보기화면에서 전달한 메모를 저장 
    var editTarget: Memo?
    
    @IBAction func close(_ sender: Any) {
        // modal 방식을 닫을 때는 dismiss 메소드 사용
        dismiss(animated: true, completion: nil)
    }
    
    // textView에 입력된 메모를 가져옴 - outlet
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        // textview에 입력된 메모를 가져와서 저장 후 화면을 닫아야 함
        // 새로운 메모는 dummyMemoList 배열에 추가
        // textField에 있는 문자열을 상수로 저장
        guard let memo = memoTextView.text,
            memo.count >= 5 else {
            // 메모를 5자 이상 작성 하지 않을 경우 경고창 표시
            alert(message: "메모를 5자 이상 입력하세요")
            return
        }
        
        // 새로운 메모 인스턴스를 생성한 후 배열에 저장
//        let newMemo = Memo(content: memo)
//        Memo.dummyMemoList.append(newMemo)
        
        // 편집모드 처리
        if let target = editTarget {
            // 텍스트뷰에 입력되어있는 값으로 메모를 변경한 후 saveContext 호출
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memoDidChange, object: nil)
        } else {
            // 반대로 쓰기 모드라면 이전 코드 그대로 작성
            DataManager.shared.addNewMemo(memo)
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
        }
        
        // addNewMemo 메소드 호출 - 데이터 저장
        // DataManager.shared.addNewMemo(memo)
        
        // 화면을 닫기 전에 notification 전달
        
        
        // 새 메모화면 닫기
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰 컨트롤러가 생성된 다음에 호출
        if let memo = editTarget {
            // 메모가 저장되어 있다면 타이틀을 메모 편집으로 설정하고, 텍스트뷰에 편집할 메모 표시
            navigationItem.title = "Edit Memo"
            memoTextView.text = memo.content
        } else {
            // 전달된 메모가 없다면 타이틀을 새 메모로 설정하고, 텍스트뷰는 빈 문자열로 초기화
            navigationItem.title = "New Memo"
            memoTextView.text = ""
        }
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

extension ComposeViewController {
    // notification 선언
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
