import UIKit
import Foundation

/*
//0~3까지의 숫자열을 순회
for idx in 0...3{
    print(idx, terminator:" ")
}
print()

//배열을 순회
let ar = ["Native App", "Hybrid App", "Web App"]
for app in ar{
    print(app)
}

//while
let sequence = 0...3
var idx = 0
while idx < 4{
    print(idx, terminator:" ")
    idx = idx + 1
}
print()

idx = 0
let size = ar.count
while idx < size{
    print(ar[idx])
    idx = idx + 1
}

//repeat ~ while
idx = 0
repeat{
    print(idx, terminator:" ")
    idx = idx + 1
}while idx < 4
print()

idx = 0
repeat{
    print(ar[idx])
    idx = idx + 1
}while idx < size
*/

/*
for i in 1...10{
    //3의 배수가 되면 반복문 종료
    if i % 3 == 0{
        break
    }
    print(i, terminator:"\t")
}
print()

for i in 1...10{
    //3의 배수가 되면 출력하지 않음
    if i % 3 == 0{
        continue
    }
    print(i, terminator:"\t")
}
print()
*/

/*
for idx in 1...5{
    //내부 반복문을 끝까지 수행했는지 확인할 변수를 생성
    var flag = false
    for j in 11...15{
        print(idx, j, terminator:"\t")
        //j가 3의 배수이면 break
        //특정 조건을 만족할 때 변수의 값을 변경
        if j % 3 == 0{
            flag = true
            break
        }
    }
    //반복문 벗어난 부분에서 변수의 값을 확인해서 종료
    if flag == true{
        break
    }
    print()
}
 */


/*
OUTER:for idx in 1...5{
    INNER:for j in 11...15{
        print(idx, j, terminator:"\t")
        if j % 3 == 0{
            //OUTER 라는 레이블을 가진 반복문을 종료
            break OUTER
        }
    }

    //반복문 벗어난 부분에서 변수의 값을 확인해서 종료
    print()
}
*/

/*
****0
***1*2
**3***4
*5*****6
789012345

=>입력을 받아서 받은 줄 수 를 가지고 모형을 생성
위의 경우는 5를 입력받았을 때 수행
*/


//2개의 매개변수 중 2번째 매개변수의 값이 0이면
//나누기 연산을 수행하지 않고 메시지를 출력하는 함수

/*
func division(split:Int, divide:Int) -> Int{
    if(divide == 0){
        print("0으로 나눌 수 없음")
        return 0
    }else{
        return split / divide
    }
 
    //어떤 문장
}

print(division(split: 10, divide: 4))
print(division(split: 10, divide: 0))
*/

/*
//guard를 사용하면 일반적으로 아래 내용을 읽을 필요가 없음
//return 하는 문장이 놓이게 됩니다.
//분기문에서 break를 표현하기 위한 형태
func division(split:Int, divide:Int) -> Int{
    guard divide != 0 else{
        print("0으로 나눌 수 없음")
        return 0
    }
        return split / divide
    
}

print(division(split: 10, divide: 4))
print(division(split: 10, divide: 0))
*/


/*
//운영체제 버전 확인
print("운영체제 버전:\(UIDevice.current.systemVersion)")

//운영체제 버전이 12 이상인 경우 동작 수행
//운영체제 버전을 정수화 해서 크기 비교를 해야 합니다.
//특정 버전에만 해당하는 경우라면 hasPrefix 로 가능
if(UIDevice.current.systemVersion.hasPrefix("12")){
    print("12.x 버전에서만 동작 ")
}else{
    print("12.x 버전이 아닌 경우에서 동작")
}

//12 이상에서 동작
if #available(OSX 12.0, *){
    print("12.0 버전 이상에서 동작")
}else{
    print("12.0 미만에서 동작")
}
*/

/*
// 문자열을 정수로 변환
var x = Int("123")
print(x)

// 예외가 아닌 nil을 리턴
x = Int("XYZ")
print(x)

x = Int("987")
print(x)
*/

/*
// nil의 명시적 해제
var x : String? = "SWIFT"
print(x) // Unwrapping 되지 않은 상태로 출력
print(x!)
x = nil
// nil인 경우는 강제 해제를 하면 에러 발생
print(x!)

let y : Int? = 234
// Optional은 바로 연산에 사용하는 것이 허용되지 않음
// print(y + 200)
print(y! + 200)
*/

/*
// 비 강제 해제 - if 나 guard 에서 표현식에 대입문을 사용해서 해제하는 경우
// Int(데이터)의 리턴 타입은 Int?
// 대입문을 사용하면 비강제 해제 진행
// print(Int(2000) + 450)
if let n = Int("2000"){
    print(n + 300)
} else {
    print ("정수로 변환 실패")
}
*/

/*
// 컴파일러에 의한 해제 - == 나 != 연산자에 사용하는 경우
var x : Int? = 300
// 컴파일러가 해제를 해서 비교를 수행
if x == 300 {
    print("2개의 데이터는 일치")
    // print(x + 500) optional이 아니므로 연산이 되지 않음
} else {
    print("2개의 데이터는 불일치")
}
*/

/*
// 묵시적 해제 : 변수를 선언할 때 ? 대신에 !를 사용
var x : Int? = 100
var y : Int! = 100
// print(x + 300)
print(y + 300)
y = nil
print(y + 300)
*/

/*
let x : Int? = 200
let y : Any = 200

// x가 Optional이라, y가 Any라 오류가 발생
// Optional은 !fh 해제해서 사용
// print(x + 100)
print(x! + 100)

// Any는 강제 형 변환을 이용해서 사용
// print(y + 100)
print((y as! Int) + 100)
*/

/*
print("Hello Swift") // 이 문장을 자주 사용하는 경우

// 함수 선언
func disp() -> Void {
    print("Hello Swift")
}

// 함수 호출
disp()

// 함수 선언
func disp(message:String, count:Int){
    // count 만큼 message 출력
    // 인덱스는 사용하지 않으므로  _
    for _ in 0..<count{
        print(message)
    }
}

disp(message: "함수", count: 3)
*/

/*
// 함수 선언
// 호출할 때 사용하는 매개변수 이름과 함수 내부에서 사용하는 매개변수 이름을 다르게 설정
func disp(msg message:String, cnt count:Int){
    // count만큼 message 출력
    // 인덱스는 사용하지 않으므로 _
    for _ in 0..<count{
        print(message)
    }
}

disp(msg: "함수", cnt: 3)
 */

/*
// 매개변수의 외부 이름을 _로 설정하면 호출할 때 이름없이 매개변수 대입 가능
// 이 문법은 거의 대부분 Protocol(interface)에서 사용
func disp(_ message:String, cnt count:Int){
    // count만큼 message 출력
    // 인덱스는 사용하지 않으므로 _
    for _ in 0..<count{
        print(message)
    }
}

disp("함수", cnt: 3)
*/

/*
// 매개변수에 기본값을 설정
// cnt는 대입하지 않으면 1
func disp(_ message:String, cnt count : Int = 1){
    // count 만큼 message 출력
    // 인덱스는 사용하지 않으므로 _
    for _ in 0..<count{
        print(message)
    }
}

disp("함수")

// 매개변수의 개수를 정하지 않는 경우 - varargs
// 매개변수를 몇 개를 대입하던지 함수 내부에서 배열로 만들어서 사용
// print 함수가 대표적이고 기본 통계 함수를 만들 때 주로 이용

func avg(data : Int ...) -> Int{
    var sum = 0
    
    // 매개변수를 순회하면서
    for temp in data {
        sum = sum + temp
    }
    return sum / data.count
}

print(avg(data: 10, 30))
print(avg(data: 10, 30, 70, 68))
*/

/*
var x = 10
func callByValue(n:Int){
    // 매개변수는 기본적으로 let
    // n = n + 1
    var y = n
    y = y + 1
    print("y:\(y)")
}
callByValue(n: x) // 11 출력
print("x:\(x)") // 10 출력

func callByReference(n : inout Int){
    n = n + 1
    print("n:\(n)")
}
callByReference(n: &x) // 11 출력
print("x:\(x)") // 11 출력
*/

/*
var x = 10
func callByValue(n:Int){
    // 매개변수는 기본적으로 let
    // n = n + 1
    var y = n
    y = y + 1
    print("y:\(y)")
}

// callByValue 함수의 참조를 cbv에게 대입
var cbv = callByValue
cbv(x)
*/

/*
// 이 함수는 매개변수가 없고 리턴 타입이 Void 인 함수를 리턴
func outer() -> (() -> Void){
    var n = 10
    // 내부 함수에서는 외부 함수의 데이터를 이용하는 것이 가능
    func inner(){
        n = n + 1
        print("n:\(n)")
    }
    
    return inner
}

// outer 함수가 리턴한 데이터를 closure에 대입
// 대입하면 참조카운트가 1 증가
let closure = outer()

// inner와 같은 함수
closure()
closure()

 */

/*
// 일반 함수로 생성
func disp() -> Void{
    print("매개변수와 리턴 타입이 없는 함수")
}
disp()


// closure 로 생성 = 직접 호출하는 경우가 거의 없음
// 이벤트 처리나 맵 리듀스 처리를 위해서 매개변수로 대입하고 이벤트가 발생하면 자동 호출
// 맵 리듀스 프로그래밍에서 함수를 알아서 각 요소에게 수행시키고 결과를 수집
var lambda = {
        () -> Void in
        print("매개변수와 리턴 타입이 없는 함수")
}
lambda()


func disp(n:Int) -> Void{
    for _ in 0..<n{
        print("매개변수가 있는 함수")
    }
}

var argLambda = {
    (n:Int) -> Void in
        for _ in 0..<n{
            print("매개변수가 있는 함수")
    }
}

argLambda(10)
*/

/*
// 변수에 저장하는 형태로 사용해서 안되는 것
var argLambda = {
        for _ in 0..<$0{
            print("매개변수가 있는 함수")
    }
}

argLambda(10)
 */

var ar = [100, 300, 200, 170, 220]

// 정렬을 위한 비교 함수
func mycomp(_ n1:Int, _ n2:Int) -> Bool{
    return n1 > n2
}

// 내림차순 정렬
ar.sort(by:mycomp)
print(ar)

// 클로저를 이용한 정렬
ar = [100, 300, 200, 170, 220]
ar.sort(by:{
    (_ n1:Int, _ n2:Int) -> Bool in
        return n1 > n2
})

print(ar)

// trailing closure 를 이용한 정렬
// 함수를 매개변수로 대입하는 경우 마지막 매개변수라면 함수 () 뒤에 closure를 연결해서
// 작성하는 것이 가능
ar = [100, 300, 200, 170, 220]
ar.sort(){
    (_ n1:Int, _ n2:Int) -> Bool in
        return n1 > n2
}

print(ar)

// **클로저에서는 매개변수의 자료형을 생략하는 것이 가능
ar = [100, 300, 200, 170, 220]
ar.sort(){
    (n1, n2) -> Bool in
        return n1 > n2
}

print(ar)

// 매개변수의 이름을 생략하고 $0, $1 형태로 사용 가능
// 리턴 타입도 생략 가능
ar = [100, 300, 200, 170, 220]
ar.sort(){
    return $0 > $1
}
print(ar)

// 내용이 한 줄 이면 return도 생략 가능
ar = [100, 300, 200, 170, 220]
ar.sort(){
    $0 > $1
}
print(ar)

// 연산자도 Closure
ar = [100, 300, 200, 170, 220]
ar.sort(by:>)
print(ar)

