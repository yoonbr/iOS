//
//  DetailVC.swift
//  winenote
//
//  Created by boreum yoon on 2021/03/16.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var url : String!
    var name : String!

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
}
