//
//  ViewController.swift
//  ViewControllerSwitching
//
//  Created by boreum yoon on 2021/02/26.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func next(_ sender: Any) {
        // 스토리보드에 디자인 한 뷰 컨트롤러 찾아오기
        let subVC = self.storyboard?.instantiateViewController(identifier: "SubViewController") as! SubViewController
        // 하위 뷰 컨트롤러 출력
        self.navigationController?.pushViewController(subVC, animated: true)
        
        // 어떤 이벤트를 이용해서 코드로 돌아가고자 하면
        self.navigationController?.popViewController(animated: true)
    }

    @IBOutlet weak var lblFirst: UILabel!
    
    // subData의 값이 변경되면 뷰를 다시 그려달라고 요청
    var subData : String!{
        didSet{
            viewIfLoaded?.setNeedsLayout()
        }
    }
    // 뷰를 다시 그릴 때 호출되는 메소드
    override func viewWillLayoutSubviews() {
        // subData가 nil이 아니면 레이블에 출력
        if let text = subData {
            lblFirst.text = text
        }
    }
    
    @IBAction func moveSecond(_ sender: Any) {
        // 이동할 뷰 컨트롤러 생성 (형변환 꼭 하기)
        // Storyboard에 설정한 Identifier를 이용
        let secondVC =
            self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        // 데이터 넘겨주기
        secondVC.msg = "하위 뷰 컨트롤러에게 넘겨주는 데이터"
        // 애니메이션 설정
        secondVC.modalTransitionStyle = .coverVertical
        // 현재 뷰 컨트롤러 위에 출력
        self.present(secondVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // 세그웨이를 이용해서 이동할 때 호출되는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // 이동할 뷰 컨트롤러 찾아오기
        let secondVC = segue.destination as! SecondViewController
        secondVC.msg = "세그웨이를 이용한 이동 "
    }
    
    // 세그웨이를 이용해서 돌아올 때 호출되는 메소드
    @IBAction func
    returned(segue:UIStoryboardSegue) {
        lblFirst.text = "세그웨이에서 돌아옴"
    }

}

