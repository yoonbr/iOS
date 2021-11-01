//
//  EditViewController.swift
//  navigation
//
//  Created by boreum yoon on 2021/10/29.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet var dateP: UIDatePicker!
    
    @IBOutlet var sg: UISegmentedControl!
    
    // 5. Edit에 viewc 심어두기
    var mainCon:ViewController?
    
    // 10. datePicker에 넣기 
    var dateTxt = ""
    
    // 14. formatter 멤버로 추가
    let fmt = DateFormatter()
    
    var imgNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 12. datePicker로 넘어갔던 데이터를 다시 출력해서 확인
        /* 데이트 피커 초기값 설정
            문자열 -> date -> datePicker
         */
        print(dateTxt)
        
        fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        // 13. 데이트피커에 문자열 지정 - date로 날짜를 받아와야 함
        // dateformatter
        let currDate = fmt.date(from: dateTxt)
        
        dateP.setDate(currDate!, animated: true)
        
        /* 17. segmentControl 초기값 설정 */
        sg.selectedSegmentIndex = imgNo
    }
    
    
    // 2. 데이트피커, 세그먼트컨 아웃렛, 버튼 액션 선언
    // 액션을 안걸고 현재있는 값만 가져와도 됨 - 수정완료일 때 작업하는 것이 더 나음
//    @IBAction func dateP(_ sender: UIDatePicker) {
//    }
//    @IBAction func sg(_ sender: UISegmentedControl) {
//    }
    
    @IBAction func backGo(_ sender: UIButton) {
        
        // 7. 포매터 생성
//        let fmt = DateFormatter()
        // fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        // 8.date 받아오기
        mainCon?.mainLB.text = fmt.string(from: dateP.date)
        
        // 9. 이미지 배열 선언 후 세그컨 값 가져오기
        mainCon?.mainImg.image = mainCon?.imgs[sg.selectedSegmentIndex]
        
        // 18.
        mainCon?.imgNo = sg.selectedSegmentIndex
        
        // 3. 현재 뷰 빠지게 작동시키기
        navigationController?.popViewController(animated: true)
        
        
    }
    
}
