//
//  DetailViewController.swift
//  NaviWeb
//
//  Created by boreum yoon on 2021/03/03.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var url : String!
    var name : String!

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = name
        
        // webView에 url을 출력
        if let address = url{
            let webURL = URL(string: address)
            let urlRequest = URLRequest(url: webURL!)
            webView.load(urlRequest)
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
