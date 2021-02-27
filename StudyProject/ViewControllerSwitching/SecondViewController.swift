//
//  SecondViewController.swift
//  ViewControllerSwitching
//
//  Created by boreum yoon on 2021/02/26.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblSecond: UILabel!
    
    // 데이터를 넘겨받을 프로퍼티 생성 (문자 숫자 여러가지 가능)
    var msg : String?
    
    
    @IBAction func moveFirst(_ sender: Any) {
        // 하위 뷰 컨트롤러에서 상위 뷰 컨트롤러로 이동하는 것은
        // 상위 뷰 컨트롤러를 만드는 것이 아니고 현재 뷰 컨트롤러를
        // 화면에서 제거해서 상위 뷰 컨트롤러를 다시 보이게 하는 것
        
        // 상위 뷰 컨트롤러를 찾아오기
        let firstVC = self.presentingViewController as! ViewController
        firstVC.subData = "상위 뷰 컨트롤러에 넘겨준 데이터"
        // 현재 출력중인 뷰 컨트롤러 제거 
        firstVC.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // msg가 null이면 아무일도 하지 않고 리턴하고
        // 그렇지 않으면 레이블에 출력(예외 발생 없음)
        // ? 가 있을 때는 이렇게 작성
        guard let t = msg else {
            return
        }
        lblSecond.text = t
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

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
