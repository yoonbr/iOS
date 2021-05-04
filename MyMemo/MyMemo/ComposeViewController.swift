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
    // 편집 이전의 메모 내용 저장
    var originalMemoContent: String?
    
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
    // keyboard notification
    // token을 저장할 속성 선언 - observer 해제시 사용
    var willShowToken: NSObjectProtocol?
    var willHideToken: NSObjectProtocol?
    
    // 소멸자를 해제하고 옵저버 해제하는 코드 생성
    deinit {
        if let token = willShowToken {
            NotificationCenter.default.removeObserver(token)
        }
        
        if let token = willHideToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰 컨트롤러가 생성된 다음에 호출
        if let memo = editTarget {
            // 메모가 저장되어 있다면 타이틀을 메모 편집으로 설정하고, 텍스트뷰에 편집할 메모 표시
            navigationItem.title = "Edit Memo"
            memoTextView.text = memo.content
            // 전달된 메모 내용 저장
            originalMemoContent = memo.content
        } else {
            // 전달된 메모가 없다면 타이틀을 새 메모로 설정하고, 텍스트뷰는 빈 문자열로 초기화
            navigationItem.title = "New Memo"
            memoTextView.text = ""
        }
        // 뷰 컨트롤러를 텍스트뷰의 델리게이트로 지정
        memoTextView.delegate = self
        
        // 키보드가 표시되기 전에 전달되는 노티피케이션
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            // 고정된 값 말고 notification에 전달된 값을 활용해서 높이를 구해야 함
            guard let strongSelf = self else { return }
            
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                // height - 키보드 높이 저장
                let height = frame.cgRectValue.height
                
                // 현재 설정되어 있는 값을 변수에 저징
                var inset = strongSelf.memoTextView.contentInset
                // bottom 속성을 키보드 높이로 변경
                inset.bottom = height
                // 변경한 inset을 contentInset에 저장 - bottom 제외한 나머지 여백 그대로 유지
                strongSelf.memoTextView.contentInset = inset
                
                // 스크롤 바에도 같은 크기 여백 추가
                inset = strongSelf.memoTextView.scrollIndicatorInsets
                inset.bottom = height
                strongSelf.memoTextView.scrollIndicatorInsets = inset
            }
        })
        // 키보드가 사라질 때 여백을 제거
        // 새로운 옵저버를 추가할 때는 addObserver 추카하는 코드 다음에 추가
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            guard let strongSelf = self else { return }
            
            // 여백 제거이므로 keyboard 높이 계산할 필요 없음
            // 현재 inset 변수로 저장
            var inset = strongSelf.memoTextView.contentInset
            // bottom 높이 0으로 설정
            inset.bottom = 0
            // 변경한 inset을 contentInset에 저장 - bottom 제외한 나머지 여백 그대로 유지
            strongSelf.memoTextView.contentInset = inset
            
            // 스크롤 바에도 같은 크기 여백 추가
            inset = strongSelf.memoTextView.scrollIndicatorInsets
            inset.bottom = 0
            strongSelf.memoTextView.scrollIndicatorInsets = inset
        
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 입력 포커스를 가진 뷰 - First Responder
        // textview를 first responder로 만들어주면 textview가 선택되고, 자동으로 키보드를 올려줌
        memoTextView.becomeFirstResponder()
        
        // 프레젠테이션 컨트롤러 델리게이트 추가로 설정
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 닫기 전 first responder 해제
        memoTextView.resignFirstResponder()
        
        // 편집화면이 표시되기 직전에 델리게이트로 설정되었다가 편집화면이 사라지기 직전에 델리게이트 해제
        navigationController?.presentationController?.delegate = nil
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

extension ComposeViewController: UITextViewDelegate {
    // textview에서 text를 편집할 때 마다 반복적으로 재생
    func textViewDidChange(_ textView: UITextView) {
        // 원본, 편집 메모를 상수에 저장
        if let original = originalMemoContent, let edited = textView.text {
            if #available(iOS 13.0, *) {
                // isModalInPresentation - 메모를 편집할 때 마다 원본과 다르면 메모가 편집된 것으로 판단
                isModalInPresentation = original != edited
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

extension ComposeViewController: UIAdaptivePresentationControllerDelegate {
    // 메모가 원본과 다를 경우 아래 메소드가 호출되고, 화면을 아래로 못 내림
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        
        // 경고창 추가
        let alert = UIAlertController(title: "notice", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        // 버튼 추가
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            // save 메소드 호출
            self?.save(action)
        }
        
        // action 추가
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] (action) in
            self?.close(action)
        }
        
        alert.addAction(cancelAction)
        
        // 경고창 표시
        present(alert, animated: true, completion: nil)
        
    }
}
extension ComposeViewController {
    // notification 선언
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
