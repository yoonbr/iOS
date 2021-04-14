//
//  ViewController.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section parameter로 분기
        switch section {
        case 0:
            return 1
            
        case 1:
            // 예보의 숫자만큼 return
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        return cell
    }
    
    
    // 2개의 section 표시 - 첫번째 섹션 : 현재 날씨, 두번째 섹션 : 날씨 예보
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

