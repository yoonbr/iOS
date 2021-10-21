//
//  ViewController.swift
//  missionTT
//
//  Created by boreum yoon on 2021/10/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var myWeb: WKWebView! // 1. 웹 뷰 아웃렛 연결
    
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. 원하는 파일의 주소를 찾아 뷰에 바로 띄우기
        let fPath = Bundle.main.path(forResource: "htmlView2", ofType: "html")
        let myUrl = URL(fileURLWithPath: fPath!)
        let myRequest = URLRequest(url: myUrl)
        
        myWeb.load(myRequest)
        
        // 3. ActivityIndicator 실행
        myWeb.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
}

