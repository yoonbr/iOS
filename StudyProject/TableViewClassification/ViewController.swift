//
//  ViewController.swift
//  TableViewClassification
//
//  Created by boreum yoon on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {
    
    // 이름을 가지고 있을 배열
    var data:Array<String> = []
    
    // 섹션별로 분류된 데이터를 저장할 배열
    var sectionData:Array<Dictionary<String, Any>> = []
    
    // 인덱스를 저장할 배열
    var indexes:Array<String> = []
    
    //문자열을 받아서 첫글자의 자음을 리턴하는 메소드
    
    func subtract(data:String) -> String{
        var result = data.compare("나")
        if result == ComparisonResult.orderedAscending{
            return "ㄱ"
        }
        
        result = data.compare("다")
        if result == ComparisonResult.orderedAscending{
            return "ㄴ"
        }

        result = data.compare("라")
        if result == ComparisonResult.orderedAscending{
            return "ㄷ"
        }
        result = data.compare("마")
        if result == ComparisonResult.orderedAscending{
            return "ㄹ"
        }
        result = data.compare("바")
        if result == ComparisonResult.orderedAscending{
            return "ㅁ"
        }
        result = data.compare("사")
        if result == ComparisonResult.orderedAscending{
            return "ㅂ"
        }
        result = data.compare("아")
        if result == ComparisonResult.orderedAscending{
            return "ㅅ"
        }
        result = data.compare("자")
        if result == ComparisonResult.orderedAscending{
            return "ㅇ"
        }
        result = data.compare("차")
        if result == ComparisonResult.orderedAscending{
            return "ㅈ"
        }
        result = data.compare("카")
        if result == ComparisonResult.orderedAscending{
            return "ㅊ"
        }
        result = data.compare("타")
        if result == ComparisonResult.orderedAscending{
            return "ㅋ"
        }
        result = data.compare("파")
        if result == ComparisonResult.orderedAscending{
            return "ㅌ"
        }
        result = data.compare("하")
        if result == ComparisonResult.orderedAscending{
            return "ㅍ"
        }
        return "ㅎ"
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 배열
        data = ["코노 쇼비뇽 블랑", "투 핸즈 엔젤스 쉬라즈", "빌라 욜란다 모스카토 다스티", "더 래키 쉬라즈", "군트럼 리슬링", "푸나무 소비뇽 블랑", "쿵푸걸 리슬링", "텍스트 북", "러시안 잭", "타피", "일레븐 미닛", "일뿌레또", "브로켈 말벡", "베어 풋", "수수마니엘로"]
        
        // 인덱스 배열
        indexes = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        
        // 데이터 분류 작업
        // 14개의 임시 배열 생성
        var temp:[[String]] = Array(repeating: Array(), count: 14)
        
        var i = 0
        while i<indexes.count{
            
            // index에서 순서대로 글자를 가져옴
            let firstName = indexes[i]
            
            var j = 0
            // 이름 배열을 순회
            while j<data.count{
                // 데이터를 하나씩 가져와서 첫글자의 자음을 찾음
                let str = data[j]
                if firstName == self.subtract(data: str){
                    temp[i].append(str)
                }
                j = j + 1
            }
            i = i + 1
        }
        // 여기서 배열 분류가 끝남
        
        // 배열 데이터 정렬 - 최적화
        i = 0
        while i < temp.count{
            if temp[i].count > 2{
                temp[i].sort()
            }
            i = i + 1
        }
        
        // Dictionary 로 만들어서 분류 배열에 삽입
        i = 0
        while i < indexes.count{
            // 배열에 데이터가 있으면
            if temp[i].count > 0{
                var dic : Dictionary<String, Any> = [:]
                // section_name에 자음을 집어넣고, data에 배열을 집어넣음
                dic["section_name"] = indexes[i]
                dic["data"] = temp[i]
                sectionData.append(dic)
            }
            i = i + 1
        }
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    // 섹션의 개수를 설정하는 코드
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    // 섹션 별 헤더 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dic = sectionData[section]
        let sectionName = (dic["section_name"] as! NSString) as String
        return sectionName
    }
    
    // 섹션의 모양을 설정하는 코드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션 번호에 해당하는 데이터를 찾아오고
        let dic = sectionData[section]
        // 찾아온 데이터의 data 키의 값을 Array로 변환
        // swift 자료형으로 바로 변환이 안되면 NSArray로 변환한 후 다시 변환하면 됨
        let ar = (dic["data"] as! NSArray) as Array
        return ar.count
    }
    
    // 셀을 만들어주는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        // 그룹을 찾고 데이터 찾아오기
        let dic = sectionData[indexPath.section]
        let ar = (dic["data"] as! NSArray) as Array
        cell!.textLabel!.text = (ar[indexPath.row] as! NSString) as String
        
        return cell!
     }
}
