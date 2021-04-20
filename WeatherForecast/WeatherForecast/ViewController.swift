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
    
    // Content Inset 새로운 속성 추가
    var topInset = CGFloat(0.0)
    
    // view의 배치가 완료된 다음 호출
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // lifecycle동안 반복적으로 호출되기 때문에 topInset이라는 속성에
        // 0.0이 저장되어있을때 한번만 구현하도록 설정
        if topInset == 0.0 {
            
            // 첫번째 셀에 해당하는 IndexPath를 만들고 셀을 가져오기
            let firstIndexPath = IndexPath(row: 0, section: 0)
            // 셀을 가지고 올때 테이블 뷰에게 요청
            if let cell = listTableView.cellForRow(at: firstIndexPath) {
                // tableview가 첫번째 셀을 리턴해주면 topInset을 계산
                // tableview의 전체 높이에서 셀의 높이를 뺀 값을 위쪽 여백 topInset으로 지정
                topInset = listTableView.frame.height - cell.frame.height
                
                // tableview에 실제로 topInset을 추가
                // 현재 지정되어있는 Inset을 가져오고 내용 여백은 contentInset 속성으로 가져오기
                // top 속성에 topInset 값을 추가 후 다시 contentInset 속성에 저장하면 topInset 값이 저장됨
                var inset = listTableView.contentInset
                inset.top = topInset
                listTableView.contentInset = inset
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰의 background 색 변경
        listTableView.backgroundColor = .clear
        // separator 표시 안함
        listTableView.separatorStyle = .none
        // 스크롤바 표시 안함
        listTableView.showsVerticalScrollIndicator = false
        
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

