//
//  Double+Formatter.swift
//  WeatherForecast
//
//  Created by boreum yoon on 2021/04/20.
//

import Foundation

// 파일 내부에서 사용할 공용 Formatter 추가
fileprivate let temperatureFormatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    // 나중에 이 코드를 제거하면 아이폰의 기본적인 locale로 설정
    f.locale = Locale(identifier: "ko_kr")
    // 소수점이 0이면 출력하지 않고, 나머지 경우에는 한자리만 출력
    f.numberFormatter.maximumFractionDigits = 1
    // 기온문자 표시 안함
    f.unitOptions = .temperatureWithoutUnit
    return f
}()

extension Double {
    // double를 기호문자로 바꾸는 속성 추가
    var temperatureString: String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return temperatureFormatter.string(from: temp)
    }
}
