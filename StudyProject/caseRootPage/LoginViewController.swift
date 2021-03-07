//
//  LoginViewController.swift
//  caseRootPage
//
//  Created by boreum yoon on 2021/03/07.
//

import UIKit

class LoginViewController: UIViewController {
    @IBAction func loginbtn(_ sender: Any) {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else { return }
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
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

