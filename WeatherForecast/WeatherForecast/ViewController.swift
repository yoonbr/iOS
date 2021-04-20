//
//  ViewController.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/07.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fetch 메소드 호출 (강남역 좌표)
        let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
        WeatherDataSource.shared.fetch(location: location) {
            self.listTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section parameter로 분기
        switch section {
        case 0:
            return 1
            
        case 1:
            // forecast에 저장되어있는 수를 리턴
            return WeatherDataSource.shared.forecastList.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            // 첫번째 섹션의 표시되는 셀의 현재 날씨를 표시
            if let weather = WeatherDataSource.shared.summary?.weather.first, let main = WeatherDataSource.shared.summary?.main {
                cell.weatherImageView.image = UIImage(named: weather.icon)
                cell.statusLabel.text = weather.description
                cell.minMaxLabel.text = "최고 \(main.temp_max.temperatureString)  최소 \(main.temp_min.temperatureString)"
                cell.currentTemperatureLabel.text = "\(main.temp.temperatureString)"
                
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        let target = WeatherDataSource.shared.forecastList[indexPath.row]
        cell.dateLabel.text = target.date.dateString
        cell.timeLabel.text = target.date.timeString
        cell.weatherImageView.image = UIImage(named: target.icon)
        cell.statusLabel.text = target.weather
        cell.temperatureLabel.text = target.temperature.temperatureString
        
        return cell
    }
    
    
    // 2개의 section 표시 - 첫번째 섹션 : 현재 날씨, 두번째 섹션 : 날씨 예보
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

