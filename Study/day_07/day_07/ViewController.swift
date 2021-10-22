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
        
        findMap(37.74731, 126.48717)
        
        // 6-2. CLLocationManagerDelegate delegate self 처리 - myLoc가 대신 위임
        myLoc.delegate = self
         
        // 6-5. 장비 권한 부여받기
        myLoc.requestWhenInUseAuthorization() // 승인 허용 요청
    }
    
    // 4. 함수화
    func findMap(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
        let cc2d = CLLocationCoordinate2DMake(lat, lon)
        let cs = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let cr = MKCoordinateRegion(
            center: cc2d,
            span: cs
        )
        myMap.setRegion(cr, animated: true)
    }

    // 2. action 연결 (segmented control)
    @IBAction func segChange(_ sender: UISegmentedControl) {
        
        // 5. segmented control 선택된 번호를 출력
        print(sender.selectedSegmentIndex) // 선택한 세그먼트 인덱스 출력
        
        let addr = sender.selectedSegmentIndex
        
        if addr == 1 { // 해운대를 선택
            findMap(35.158627, 129.160341)
            titleLB.text = "해운대 해수욕장"
            addrLB.text = "부산광역시 해운대"
            
        } else if addr == 2 { // 우리집 선택
            findMap(37.48103, 126.95794)
            titleLB.text = "우리집"
            addrLB.text = "서울특별시 관악구 봉천동"
            
        } else if addr == 0 { // 현위치 선택
            // 6-3
            myLoc.startUpdatingLocation() // 내 위치 정보 받기
        }
    }
    
    // 6-4. myLoc.startUpdatingLocation() // 내 위치 정보 받기 이후 자동 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 6-6. 좌표 정보 가져오기 - 마지막 위치의 좌표를 알려줌
        let lastLoc = locations.last?.coordinate
        
        let lastLat = lastLoc!.latitude
        let lastLon = lastLoc!.longitude
        
        print("locationManager 실행 \(lastLat), \(lastLon)")
        
        findMap(lastLat,lastLon)
        
        titleLB.text = "현위치"
        addrLB.text = "주소"
        
        myLoc.stopUpdatingLocation() // 현재 좌표 갱신 중지, 누를 때만 갱신
    }
    
}
