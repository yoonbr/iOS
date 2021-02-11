import UIKit
import Foundation

/*
var x = 10
for idx in 1...5{
    let y = idx * x
    x = x - 1
    print(y)
}
 */

/*
 
let frame = CGRect(x: 100, y: 100, width: 150, height: 75)
let label = UILabel(frame: frame)

label.backgroundColor = UIColor.red
label.textAlignment = .center
label.text = "UIKit test"

let image = UIImage(named: "restroom_sign")

import PlaygroundSupport

let container = UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
PlaygroundPage.current.liveView = container
container.backgroundColor = UIColor.white
let square = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))

square.backgroundColor = UIColor.red

container.addSubview(square)

UIView.animate(withDuration: 5.0, animations: {
    square.backgroundColor = UIColor.blue
    let rotation = CGAffineTransform(rotationAngle: 3.14)
    square.transform = rotation
})

let rect = CGRect(x: 100, y: 200, width: 150, height: 100)
print(rect)
debugPrint(rect)
 
// 내부 요소를 자세히 출력
dump(rect)
NSLog("Hello")
 
print("Java", "JavaScript", separator:"...")
print("Java", terminator:" ")
print("JavaScript")

// 정수 변수 생성
var count : Int = 30

// 실수 상수 생성
let avg : Double = 20.7

// let은 상수를 저장할 때 사용하므로 값을 변경할 수 없음
// avg = 30.8

// 출력
print("count : ", count)
print("avg : ", avg)

// 실수는 표현 범위의 한계 때문에 예측하지 못하는 결과가 만들어질 수 있음
// 결과가 "2.2 - 2.1 은 0.1이 아님" 이 출력됨
if 2.2 - 2.1 == 0.1 {
    print("2.2 - 2.1 은 0.1")
} else {
    print("2.2 - 2.1 은 0.1이 아님")
}

// 타입 추론을 이용한 변수 생성
var n = 10 // 10이 정수이므로 n의 자료형은 Int

var d1 = 10.8 // Double
var d2 : Float = 10.8 // Float 생성

var str = "H" // String
var ch : Character = "H" // 문자 자료형으로 만들기
print(str is String)
print(ch is Character)

// 문자열 템플릿을 이용해서 문자열 생성
var msg = "n:\(n)"
print(msg)

// 여러 줄 문자열 생성 - """ 좌우에는 문자열이 오면 안됨
print("""
        Hello
        MultiLine
        Literal
    """)

var n1:Int = 20
var n2:Int32 = 30
// Int와 Int32의 + 연산 불가 - 자료형이 다르기 때문
// print(n1+n2)

// 하나의 데이터를 다른 데이터의 자료형으로 형 변환해서 사용
print(n1 + Int(n2))

// 자료형 확인
print(n1 is Int)
print(n1 is Int32)


let n1 : Int16 = +15000
let n2 : Int16 = +20000

// 2개의 합은 32767을 넘어서기 때문에 Overflow 발생
// &+ 를 이용해서 Overflow 가 발생하면 가장 적은 숫자부터
// 다시 시작하도록 해주면 에러는 아님.
// error
// let result : Int16 = n1 + n2
// result:-30536
let result : Int16 = n1 &+ n2
print("result:\(result)")

// 실수는 나머지를 %로 구하지 못함
// print(1.7 % 3.5)
print(1.7.truncatingRemainder(dividingBy: 3.5))


// 2개의 문자열 객체 생성
let str1 = NSString(format: "%@", "Swift String")
let str2 = NSString(format: "%@", "Swift String")

// 값을 비교하기 때문에 true
print(str1 == str2)
// 자신의 참조를 비교
print(str1 === str2)


 */

/*
let isFlag = false
// isFlag == 대신에 !isFlag로도 많이 사용
// if isFlag == false{

if !isFlag{
    print("isFlag 는 false")
}

 

var x = 19
var y = -23 // 음수는 양수의 2의 보수로 저장

// 19 : 00000000 00000000 00000000 00010011
// -23 : 11111111 11111111 11111111 11101001

16 + 4 + 2 + 1

print(~19)
print(x&y)
print(x|y)
print(x^y)
print(x<<2)
print(x>>2)
// 10진수를 2진수 문자열로 만드는 코드는 직접 구현

print(1...10)
print(1..<10)
print((1...10).reversed())

let score = 88
// 90 ~ 100은 A
// 60 ~ 89까지는 B
// 0 ~ 59 까지는 C

if(score >= 90 && score <= 100) {
    print ("A")
} else if (score >= 60 && score <= 89) {
    print ("B")
} else if (score >= 0 && score <= 59) {
    print ("C")
} else {
    print("잘못된 점수")
}

// 위의 문장을 switch로 표현
switch score {
case 90...100:
    print("A")
case 60..<90 where score % 2 == 1:
    print("B 이면서 홀수 점수")
case 60..<90 where score % 2 == 0:
    print("B 이면서 짝수 점수")
case 0..<60:
    print("C")
default:
    print("잘못된 점수")
}

switch (score) {
case 90,91,92,93,94,95,96,97,98,99,100:
    print("A")
case 60..<90:
    print("B")
case 0..<60:
    print("C")
default:
    print("잘못된 점수")
}

// 값을 사용할 때 where를 추가해서 조건을 더 추가하는 것이 가능
switch (score){
case 90,91,92,93,94,95,96,97,98,99,100:
    print("A")
case 60..<90 where score % 2 == 1:
    print("B 이면서 홀수")
case 60..<90 where score % 2 == 0:
    print("B 이면서 홀수")
case 0..<60:
    print("C")
default:
    print("잘못된 점수")
}
*/

// tuple

var data = (80, "bonnie")

// 튜플을 대입받아서 튜플의 일부분을 가지고 분기 할 수 있음
switch data {
case (0..<60, data.1):
    print("\(data.1)는 성적이 낮습니다")
case (60..<80, data.1):
    print("\(data.1)는 성적이 보통입니다")
case (80..<100, data.1):
    print("\(data.1)는 성적이 우수합니다")
default:
    print("\(data.1)는 성적이 이상합니다")
}

/*
 // 0부터 3까지를 만들고 순회하면서 출력
for idx in 0...3 {
    print(idx)
}

var list = ["아메리카노", "카페라떼", "아이스초코"]

for cafe in list {
    print(cafe)
}
*/
