//
//  ViewController.swift
//  webViewTT
//
//  Created by boreum yoon on 2021/10/20.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var myWeb: WKWebView!
    
    @IBOutlet var urlText: UITextField!
    
    // use typealias
    typealias TU = (name:String, url:String)
    
    let arr:[TU] = [
        ("애플", "https://www.apple.com/"),
        ("네이버", "https://m.naver.com"),
        ("구글", "https://www.google.com"),
        ("다음", "https://m.daum.net"),
        ("네이트", "https://m.nate.com")
    ]
    
    /*
    let urls = [
        "https://www.apple.com/",
        "https://m.naver.com",
        "https://www.google.com",
        "https://m.daum.com",
        "https://m.nate.com"
    ]
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func goToWeb(_ addr:String) {
        
        let url = URL(string: addr)!
        let req = URLRequest(url: url)
        myWeb.load(req)
        urlText.text = addr
        
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        goToWeb(arr[row].url)
    }
}
