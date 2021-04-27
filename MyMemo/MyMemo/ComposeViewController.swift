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
