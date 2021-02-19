import UIKit
import Foundation


// @objc를 추가한 이유는 @objc optional 이라는 예약어를 사용하기 위해서
// 메소드 볼때 optional유무 확인
@objc protocol MediaPlayer{
    // conform 한 클래스에서 이 프로퍼티를 구현해야 함
    var isPlay:Bool{get set}
    
    func play()
    
    // func nextMedia() // 아래 클래스에 오류 발생
    @objc optional func nextMedia()

}

class DVDPlayer : MediaPlayer{

    // swift에서는 프로토콜의 메소드나 프로퍼티 또는 init을 구현할 때 override를 붙이지 않음
    // 상위 클래스의 메소드를 재정의할때만 override를 붙임
    var isPlay : Bool = false
    
    func play() {
        print("재생")
        isPlay = true
    }
}

// SwiftUI에서 많이 사용하므로 꼭 알아둘 것
// View 라는 프로토콜
protocol View{}

// View라는 프로토콜을 conform하는 클래스
class TextView:View{}

class ImageView:View{}

// View는 프로토콜이므로 인스턴스를 만들 수 없음
// 이 메소드의 의미는 View 프로토콜을 conform 클래스의
// 인스턴스를 리턴하는 의미
func disp1() -> some View{
    return TextView()
}

func disp2() -> some View {
    return ImageView()
}

print(disp1())
print(disp2())

// 선택적 구현 메소드를 가진 프로토콜 생성
@objc protocol TableViewDelegate {
    @objc optional func eventHandling()
}

// 필수 구현 메소드를 가진 프로토콜 생성
protocol TableViewDataSource{
    func display()
}
/*
class TableView:TableViewDelegate,
    TableViewDataSource{
    
    func mynamePrint(){
        print("Table View")
    } // errer 프로토콜의 메소드를 구현 안함
    
    // 프로토콜의 메소드를 구현해서 에러를 제거
    func eventHandling() {
        print("이벤트 처리를 위한 메소드")
    }
    
    func display() {
        print("출력을 위한 메소드")
    }
}


class TableView{
    
    func mynamePrint(){
        print("Table View")
    }
}
    
let tableView = TableView()
tableView.mynamePrint()
tableView.display()
tableView.eventHandling()

extension TableView: TableViewDelegate {
    func eventHandling() {
        print("이벤트 처리를 위한 메소드")
    }
}

extension TableView: TableViewDataSource {
    func display() {
        print("출력을 위한 메소드")
    }
}

// C언어는 함수 오버로딩이나 템플릿 프로그램을 지원하지 않음

// 정수와 정수 그리고 실수와 실수 데이터의 위치를 교환하는 함수
func swapInt(n1 : inout Int, n2 : inout Int){
    let temp : Int = n1
    n1 = n2
    n2 = temp
}

func swapDouble(n1 : inout Double, n2 : inout Double){
    let temp : Double = n1
    n1 = n2
    n2 = temp
}

var n1 = 10
var n2 = 20

var d1 = 10.7
var d2 = 20.3

swapInt(n1: &n1, n2: &n2)
swapDouble(n1: &d1, n2: &d2)

print("n1:\(n1) n2:\(n2)")
print("d1:\(d1) d2:\(d2)")

// 함수 오버로딩 (Overloading - 중복 정의)
// 함수의 이름은 같고 매개변수의 개수나 자료형이 다른 경우
// 동일한 알고리즘을 사용하는 함수의 이름은 같은게 좋음 (애플은 특별한 경우가 아니면 overloading 하지 않음)

func swapNumber(n1 : inout Int, n2 : inout Int){
    let temp : Int = n1
    n1 = n2
    n2 = temp
}

func swapNumber(n1 : inout Double, n2 : inout Double){
    let temp : Double = n1
    n1 = n2
    n2 = temp
}
// 동일한 이름의 함수가 여러가지 매개변수를 받는 경우 오버로딩 보다는 제너릭이나
// 다른 이름을 사용하는 것이 좋다고 생각하는 개발자도 있음

swapNumber(n1: &n1, n2: &n2)
swapNumber(n1: &d1, n2: &d2)

print("n1:\(n1) n2:\(n2)")
print("d1:\(d1) d2:\(d2)")

// 제너릭 이용
// 미지정 자료형 이름을 이용(T 사용)
func swapGeneric<T>(n1 : inout T, n2 : inout T){
    let temp : T = n1
    n1 = n2
    n2 = temp
}

swapNumber(n1: &n1, n2: &n2)
swapNumber(n1: &d1, n2: &d2)

print("n1:\(n1) n2:\(n2)")
print("d1:\(d1) d2:\(d2)")



// 특수문자 : command + control + spacebar
let str = "iOS는 그림문자 사용 가능 🙃"
for code in str.utf8 {
    print(code)
}

*/

class Item{
    var num:Int
    var name:String
    var price:Int
    var score:Double
    
    init(){
        self.num = 0
        self.name = "noname"
        self.price = 0
        self.score = 0.0
    }
    
    init(num:Int, name:String, price:Int, score:Double){
        self.num = num
        self.name = name
        self.price = price
        self.score = score
    }
}

var strAr = ["Java", "JavaScript", "Kotlin", "Swift"]
var itemList = [Item]()

// 배열에 데이터를 추가
var item = Item(num: 1, name: "루이 마티니 나파밸리 카베르네 소비뇽", price: 39000, score: 94.3)
itemList.append(item)

item = Item(num: 2, name: "폰토디 끼얀티 클라시코 2015", price: 31000, score: 94.0)
itemList.append(item)

item = Item(num: 3, name: "구아도 알 타쏘 콘투고 2016", price: 70000, score: 96.2)
itemList.append(item)

item = Item(num: 4, name: "알레한드로 페르난데스 뻬스께라 크리안자 2015", price: 30000, score: 92.6)
itemList.append(item)

// 배열 중간에 데이터를 삽입
itemList.insert(item, at: 2)

// 배열의 데이터 개수 확인
print("데이터 개수:\(itemList.count)")

// 배열의 데이터 순회
for str in strAr{
    print(str, terminator:"\t")
}
print()

// 배열에서 2번째 데이터 가져오기
print("2번째 데이터:\(strAr[1])")

// 데이터를 2개씩 가져오는 경우
// \() 부분이 똑같이 기재되어야 함
var pageno = 1
print("1page:\(strAr[((pageno-1)*2)..<(pageno*2)])")

pageno = 2
print("2page:\(strAr[((pageno-1)*2)..<(pageno*2)])")

// 데이터 정렬하기 - 기본적인 크기 비교 연산자를 이용해서 비교한 후 정렬(sort로 하면 리턴안됨)
print(strAr.sorted())
// 기본 자료형의 경우는 크기 비교 연산자가 정의되어 있어서 이 방식으로 가능
print(strAr.sorted(by:>))

// 배열 자체를 정렬
// itemList.sort() // Item 클래스는 크기 비교 메소드가 없으므로 정렬이 되지 않음
// 매개변수가 2개, Bool을 리턴
// 이름가지고 오름차순 비교
itemList.sort(by: {$0.name > $1.name})
for item in itemList {
    print(item.name)
}

print()

// 가격의 내림차순 정렬 - 클로저의 문법이 다양하므로 클로저를 보고 작성할 수어야 함
itemList.sort(by: {(item1:Item, item2:Item) -> Bool in
    return item.price > item2.price
})

for str in strAr{
    print(str, terminator:"\t")
}
print()

//Item의 price만 추출
var result:[Int] = itemList.map ({(item:Item) -> (Int) in
    return item.price
})

print(result)

// trailing 클로저 이용 - 클로저가 마지막 매개변수인 경우 () 뒤에 기재해도 됨
result = itemList.map(){(item:Item) -> (Int) in
    return item.price
}

print(result)

// 필터링 : 조건에 맞는 데이터만 추출 - price가 30000이 넘는 데이터 호출 
var itemFilter = itemList.filter({(item:Item) -> (Bool) in item.price > 30000})
for item in itemFilter {
    print(item.name, terminator:"\t")
}
