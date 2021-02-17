import UIKit

/*
// 심각한 오류가 발생했을 때 호출될 메소드
// Never는 정상적인 문장에 끝나면 안됨 - fatalError
// 이 메소드는 리턴타입이 Never이므로 이 메소드의 호출이 끝나면 프로세스는 중단
func crashAndBurn() -> Never{
    // 아래 메시지를 출력하고 현재 프로세스를 중단
    fatalError("더 이상 수행할 수 없는 상황 발생")
}

/*
func someFuction(isWell:Bool){
    if(isWell == true){
        print("작업을 수행")
    } else {
        print("이상한 상황이 발생해서 프로그램을 중단")
        crashAndBurn()
    }
}
 */

someFuction(isWell: true)
// 강제 예외 발생
someFuction(isWell: false)
print("이 문장은 실행되지 않음")

// 심각한 오류가 발생하는 메시지를 작성할때는 if를 사용하지 말고
// 바꿔서 작성
func someFuction(isWell:Bool){
    // isWell이 true가 아니면 정상 수행되지 않는다라고 해석
    guard isWell == true else {
        print("이상한 상황이 발생해서 프로그램을 중단")
        crashAndBurn()
    }
    print("작업을 수행")
}


// 매개변수가 없는 disp
func disp(){
    print("Hello Swift")
}

// 매개변수가 있는 disp - 이런 경우를 overloading 이라고 함
func disp(cnt : Int){
    for _ in 0..<cnt{
        print("Hello Swift")
    }
}

// overloading 된 함수는 함수를 호출할 때 자신의 원형과 일치하는 함수를 찾아서 실행함
// 실행 후에 매개변수가 없는 것을 찾아서 실행
disp()
// 실행 후에 매개변수가 있는 것을 찾아서 실행
disp(cnt: 10)


// ** 다음에 데이터가 와야 함
// 데이터는 통상적으로 1개만 와야함 2개는 헷갈릴 수 있음
prefix operator **

prefix func ** (value : Int) -> Int {
    return value * value
}

print(**10)

// 존재하는 연산자를 재정의
prefix func !(value : String) -> Bool{
    return value.isEmpty
}
print(!"Swift") // 안비어있으므로 false
print(!"") // 비어있으므로 true

// 중위 연산자 재정의
infix operator ** : MultiplicationPrecedence
// base를 base2 만큼 곱해서 리턴
func **(base:Int, base2:Int) -> Int {
    var x = base
    for _ in 0..<base2 - 1 {
        x = x * base
    }
    return x
}

print(3 ** 5)
 */

// 예전엔 이렇게 작성
/*
enum MultiMedia {
    case NONE
    case TEXT
    case AUDIO
    case MOVIE
    case IMAGE
}


// 자료형 문자열도 가능 Int대신 String 대입
// 메소드 대입도 가능
enum MultiMedia : Int, CaseIterable{
    case none = 100
    case text = 200
    case audio
    case movie = 300
    case image
    
        // 함수를 추가하는 것이 가능
    func display(){
        switch self {
        // swift 에서는 switch 구문을 사용할 때 모든 상황에 작업이 수행될 수 있도록 해야 함
        // default가 필수인 것 처럼 느껴짐
        // 열거형은 선언된 경우만 처리하면 default가 없어도 됨
        // 모든 데이터를 선언해주면 default가 없다고 오류가 나지 않음
        case .none:
            print("타입이 없음")
        case .text:
            print("문자열이 저장되어 있음")
        case .audio:
            print("음성이 저장되어 있음")
        case .movie:
            print("영상이 저장되어 있음")
        case .image:
            print("이미지가 저장되어 있음")
        }
    }
}

// enum 값을 설정
var type = MultiMedia.text

// 자료형이 명시된 경우는 열거형 이름을 생략할 수 있음
var mType:MultiMedia = .audio

// mType = 10 // error

// rowValue 출력
print(type.rawValue) // 200
// mType은 값을 설정하지 않았으므로 이전 값인
// text의 값에 + 1이 적용됨
print(mType.rawValue) // 201

// 함수 출력 가능
type.display()

// 열거형 순회 - CaseIterable 프로토콜을 conform 해야 함
for temp in MultiMedia.allCases{
    print(temp)
}

// rawValue를 이용한 초기화
var objc = MultiMedia(rawValue: 301) // 301이 없는 값일 수도 있으므로 Optional
print(objc)

// objc 값을 변경하지 않을땐 let 사용


// 이름, 고향, 나이를 저장하는 구조체를 생성
struct Person {
    var name : String
    var hometown : String
    var age : Int
    
    func disp(){
        print("이름은 \(name) 이고 고향은 \(hometown) 이며 나이는 \(age) 입니다.")
    }
}

// 구조체의 인스턴스 생성
// var person1 = Person()
// 구조체는 모든 프로퍼티의 값을 대입받아서 생성해주는 init이 존재
let person2 = Person(name: "bonnie", hometown: "korea", age: 29)
person2.disp()
// var로 선언되었기 때문에 age의 값을 변경할 수 있음
// person2가 let으로 선언되었다면 변경불가
// person2.age = 45

// 구조체와 클래스가 다른 점
// struct
struct Person {
    var name : String
    var hometown : String
    var age : Int
    
    func disp(){
        print("이름은 \(name) 이고 고향은 \(hometown) 이며 나이는 \(age) 입니다.")
    }
}

var person1 = Person(name: "yoond", hometown: "osan", age: 29)
// 구조체 인스턴스를 다른 변수에 대입 : 내부 데이터 값을 복사해서 새로운 인스턴스를 대입
var person2 = person1
person1.disp()
person2.disp()

// person2의 내용을 변경 : 데이터를 복제해서 생성했으므로 한 쪽을 변경하더라도 다른 쪽에는 영향이 없음
person2.hometown = "suwon"
person1.disp()
person2.disp() // hometown 변경

// class
class Human {
    var name : String
    var hometown : String
    var age : Int
    
    init(name:String, hometown:String, age:Int) {
        self.name = name
        self.hometown = hometown
        self.age = age
    }
    
    func disp(){
        print("이름은 \(self.name) 이고 고향은 \(self.hometown) 이며 나이는 \(self.age) 입니다.")
    }
}

// 클래스의 인스턴스는 참조를 저장하고 있기 때문에
// 다른 변수에 대입하면 참조가 대입됨
// 어느 한쪽에서 내부 데이터를 변경하면 다른 한쪽에도 영향을 미치게 됨

var human1 = Human(name: "yoon", hometown: "경기", age: 29)
var human2 = human1
human1.disp()
human2.disp()

human2.hometown = "강남"
human1.disp()
human2.disp()

 */

// 시작점의 좌표 - x, y
// 너비와 높이 - width, height
// 위의 둘은 입력을 받아야 함
// 중앙점의 좌표 - (x, y) : 이전 정보를 이용해서 생성이 가능
// 이런 경우 중앙점의 좌표를 별도로 저장 할 것인가 아니면 매번 계산을 할 것인가
// 연산 프로퍼티 : 이런 경우 별도로 저장하는 것처럼 선언하고 실제로는 매번 계산을 수행하는 프로퍼티
// 를 저장하는 클래스를 생성

/*
// 객체지향 중 중요한 개념의 하나
class Rect{
    // 저장 프로퍼티 - 클래스나 구조체 안에서 변수를 선언하듯이 작성
    var x = 0
    var y = 0
    var width = 0
    var height = 0
    // 연산 프로퍼티
    var center : (Int, Int){
        get {
            return ((x+width)/2, (y+height)/2)
        }
        // center의 값을 변경하고자 하면 x와 y좌표 수정
        set(value) {
            x = (value.0 - width/2)
            y = (value.1 - height/2)
        }
    }
}

let rect = Rect()
rect.x = 100
rect.y = 50
rect.width = 200
rect.height = 150

// rect.center를 부를 때 계산을 실행
// 저장 프로퍼티처럼 호출했지만 실제로는 연산을 수행해서 그 결과를 가져옴
print(rect.center)


rect.center = (200, 200)
print(rect.x, ":", rect.y)

// 지연생성 : init을 호출할 때 만들어지지 않고 처음 사용할 때 생성되는 것
class Inner {
    init() {
        print("지연생성")
    }
}

class Outer {
    // 이 프로퍼티가 처음 사용될 때 생성
    lazy var lazyinit = Inner()
    init() {
        print("외부객체 생성")
    }
}

let outer = Outer()
print("memo")
print(outer.lazyinit)

class Data {
    var n = 0 {
        willSet(value){
            print("n의 값이 \(value)로 변경되기 직전입니다.")
        }
        didSet{
            print("n의 값이 \(oldValue)에서 변경되었습니다.")
            // 검사를 해서 범위를 넘어서면 다른 값으로 변경
            if n > 100 {
                n = 0
            }
        }
    }
    // 클로저는 함수의 일종이기 때문에 이벤트를 만나거나 ( )가 있어야 실행 됨
    var name : String = {
        // 클로저는 코드를 써줌
        print("클로저를 이용한 프로퍼티 초기화")
        return "closure"
    }()
    
    // type 프로퍼티
    // static은 붙여도 에러가 나지 않지만 class를 붙이면 에러 발생
    // static var auto_inc = 0
    // static은 상관없지만 class를 붙일 때는 여산 프로퍼티로 생성
    class var auto_inc:Int {
        get{
            return 5 + 10
        }
    }
}

// 구조체는 var로 만드는 경우가 많고, class 인스턴스는 let으로 주로 생성
// 인스턴스 생성 - 메모리 할당 함수 -> init 함수 실행
let data = Data()
// data.name을 가져와서 사용하고자 할 때 closure가 수행(지연생성과 유사)
// 지연생성은 코드를 쓰지는 못함. 나중에 만들어달라 요청을 하는 것
print(data.name)
data.n = 120
print(data.n)

print(Data.auto_inc) // 타입 프로퍼티는 클래스 이름으로 접근 가능

print(data.auto_inc) // 타입 프로퍼티는 인스턴스 이름으로 접근하려고 하면 안됨

// 메인에서 값을 번거롭게 변경하는 작업을 하지 않아도 됨
// 클로저도 작업을 해서 가져온 것이므로 연산프로퍼티에 속함
*/


struct Stuff {
    var name:String
}
let bonnie = Stuff(name:"bonnie")
print(bonnie.name)

// KeyPath : 프로퍼티의 참조를 저장하는 것
let stuffNameKeyPath = \Stuff.name
print(bonnie[keyPath: stuffNameKeyPath])
