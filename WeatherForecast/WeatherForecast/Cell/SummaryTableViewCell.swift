//
//  SummaryTableViewCell.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/13.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    static let identifier = "SummaryTableViewCell"
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var minMaxLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // 셀의 background color 변경
        backgroundColor = .clear
        
        statusLabel.textColor = .white
        // 나머지 레이블에도 statusLabel.textColor 그대로 저장
        minMaxLabel.textColor = statusLabel.textColor
        currentTemperatureLabel.textColor = statusLabel.textColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
