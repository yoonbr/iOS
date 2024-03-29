//
//  Extensions.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/06/01.
//

import Foundation
import UIKit

// UIView extension 생성
extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "YYYY-MM-dd"
        return dateForamtter
    }()
    
    static let displaydateFormatter: DateFormatter = {
        let dateForamtter = DateFormatter()
        dateForamtter.dateStyle = .medium
        return dateForamtter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displaydateFormatter.string(from: date)
    }
}

