//
//  ViewController.swift
//  day_07
//
//  Created by boreum yoon on 2021/10/22.
//

import UIKit
import MapKit

// 6. 지역정보 관리하는 protocol 위임
class ViewController: UIViewController, CLLocationManagerDelegate {

    // 1. outlet 연결 (mapView, label)
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var titleLB: UILabel!
    @IBOutlet var addrLB: UILabel!
    
    // 6-1. 지역정보 받아올 변수 선언
    let myLoc = CLLocationManager() // 위치 정보 받을 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // 3. 실행시 보여질 지도의 위치 경도,위도 찾아오기
        // 강화도 시장 : 37.74731, 126.48717
        // 3-3. 좌표 정보, 배율 상수 선언
        let cc2d = CLLocationCoordinate2D(
            latitude: 37.74731,
            longitude: 126.48717
        )
            // (경도 배율, 위도 배율 - 작아질 수록 확대됨)
        let cs = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        
        // 3-2. 좌표 지역 (center: 좌표, span: 배율)
        let cr = MKCoordinateRegion(
            center: cc2d, // 지역 가운데 위치
            span: cs // 배율
        )
        
        // 3-1. 지도 지역 설정
        myMap.setRegion(cr, animated: true)
         */
        
        // findMap(37.74731, 126.48717) // 임시 좌표로 처음 뜨는 지도 표시 
        myLoc.startUpdatingLocation()
        
        // 6-2. CLLocationManagerDelegate delegate self 처리 - myLoc가 대신 위임
        myLoc.delegate = self
         
        // 6-5. 장비 권한 부여받기
        myLoc.requestWhenInUseAuthorization() // 승인 허용 요청
        
        // 7. 내 위치 표시
        myMap.showsUserLocation = true // 지도에서 내 위치 표시
        
        // 7-3. setPoint 실행
        // setPoint()
        
    }
    
    // 4. 함수화
    // title 추가
    func findMap(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees, _ title:String) {
        let cc2d = CLLocationCoordinate2DMake(lat, lon)
        let cs = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let cr = MKCoordinateRegion(
            center: cc2d,
            span: cs
        )
        myMap.setRegion(cr, animated: true)
        
        let lastLoc = CLLocation(latitude: lat, longitude: lon)
        var addrTT = ""
        // var addrS = ""
        
        // 7-1. 현재 위치의 주소를 표시 (handler 사용)
        CLGeocoder().reverseGeocodeLocation(lastLoc) { place, _ in // { 위치정보, 에러 발생 정보 in
            let pp = place!.first!
            
            addrTT = pp.country! // 국가
            addrTT += " " + pp.locality! // 시,도
            addrTT += " " + pp.thoroughfare! // 동
    
            // addrTT의 주소를 label에 출력
            self.addrLB.text = addrTT
        }
        titleLB.text = title
        
        setPoint(title: title, subtitle: "Test?", pLoc: cc2d)
    }
    
    // 7-2. 함수 생성
    // 7-3. 함수에 매개변수 세개를 생성하여 외부에서 정보를 받게 실행
    func setPoint(title:String, subtitle:String, pLoc:CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        
        pin.title = title
        pin.subtitle = subtitle
        
        pin.coordinate = pLoc
        
        myMap.addAnnotation(pin)
    }

    // 2. action 연결 (segmented control)
    @IBAction func segChange(_ sender: UISegmentedControl) {
        
        // 5. segmented control 선택된 번호를 출력
        print(sender.selectedSegmentIndex) // 선택한 세그먼트 인덱스 출력
        
        let addr = sender.selectedSegmentIndex
        
        if addr == 1 { // 해운대를 선택
            findMap(35.158627, 129.160341, "해운대 해수욕장")
            // titleLB.text = "해운대 해수욕장"
            // addrLB.text = "부산광역시 해운대"
            
        } else if addr == 2 { // 우리집 선택
            findMap(37.48103, 126.95794, "우리집")
            // titleLB.text = "우리집"
            // addrLB.text = "서울특별시 관악구 봉천동"
            
        } else if addr == 0 { // 현위치 선택
            // 6-3
            myLoc.startUpdatingLocation() // 내 위치 정보 받기
        }
    }
    
    // 6-4. myLoc.startUpdatingLocation() // 내 위치 정보 받기 이후 자동 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 6-6. 좌표 정보 가져오기 - 마지막 위치의 좌표를 알려줌
        let lastLoc = locations.last
        
        let lastLat = (lastLoc?.coordinate.latitude)!
        let lastLon = (lastLoc?.coordinate.longitude)!
        
        print("locationManager 실행 \(lastLat), \(lastLon)")
        
        /*
        // 7-1. 현재 위치의 주소를 표시 (handler 사용)
        CLGeocoder().reverseGeocodeLocation(lastLoc!) { place, _ in // { 위치정보, 에러 발생 정보 in
            let pp = place!.first!
            
            var addrTT = pp.country! // 국가
            addrTT += " " + pp.locality! // 시,도
            addrTT += " " + pp.thoroughfare! // 동
            
            self.titleLB.text = "현위치"
            // addrTT의 주소를 label에 출력
            self.addrLB.text = addrTT
            
        }
         */
        // titleLB.text = "현위치"
        findMap(lastLat,lastLon,"현위치")
        
        myLoc.stopUpdatingLocation() // 현재 좌표 갱신 중지, 누를 때만 갱신
    }
    
}


