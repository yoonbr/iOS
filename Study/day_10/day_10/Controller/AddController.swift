//
//  AddController.swift
//  day_10
//
//  Created by boreum yoon on 2021/11/01.
//

import UIKit

class AddController: UIViewController {

    // 3. add 기능 추가
    @IBOutlet var addTF: UITextField!
    
    @IBOutlet var sg: UISegmentedControl!
    
    var mainCon: MainController?
    
    var imgNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addGo(_ sender: UIButton) {
        
        // 3-1. txtArr에 text를 집어넣을 수 있게 선언
        txtArr.append(addTF.text!)
        
        // 3-2. 이미지 고정 추가
        imgArr.append(UIImage(named: "\(sg.selectedSegmentIndex).png"))

        // 3-3. 창 닫게 하기
        navigationController?.popViewController(animated: true)
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
