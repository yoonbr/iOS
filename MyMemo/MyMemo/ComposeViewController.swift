//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by boreum yoon on 2021/04/27.
//

import UIKit

class ComposeViewController: UIViewController {
    
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
        let newMemo = Memo(content: memo)
        Memo.dummyMemoList.append(newMemo)
        
        // 새 메모화면 닫기
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
