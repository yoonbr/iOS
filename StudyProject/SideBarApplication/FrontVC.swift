//
//  FrontVC.swift
//  SideBarApplication
//
//  Created by boreum yoon on 2021/03/18.
//

import UIKit

class FrontVC: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 사이드 바 버튼의 기능을 설정
        // 스와이프 할 때도 동작하도록 설정을 추가
        
        if let revealVC =
            self.revealViewController(){
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(animated:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }

}
