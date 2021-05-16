//
//  MapDetailViewController.swift
//  winenote
//
//  Created by boreum yoon on 2021/05/16.
//

import UIKit
import WebKit

class MapDetailViewController: UIViewController {
    
    var url: String!
    var name: String!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = name
        
        // webView에 url 출력
        if let address = url {
            let webURL = URL(string: address)
            let urlRequest = URLRequest(url: webURL!)
            webView.load(urlRequest)
        }
    }
}
