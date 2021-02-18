import UIKit

/*
 class ClassPoint{
    
    var x = 0
    
    // 인스턴스 메소드
    // 함수나 메소드 앞에 @objc를 추가하면 Objective-c로 만들어진 API에서도 사용 가능
    @objc func get() -> Int {
        return x
    }
    func set(x:Int) -> Void{
        // self는 init과 인스턴스 메소드에서
        // 인스턴스 자신을 나타내는 포인터
        // 숨겨진 형태로 제공되는 경우가 많고 이름은 언어마다 조금씩 다른데
        // 보통 this 아니면 self
        
        // self가 붙으면 메소드 내부에서는 찾지 않음
        self.x = x

    }
    
    // 클래스가 호출할 수 있는 타입 메소드
    static func disp() -> Void {
        // print("\(x)") // static 없는 x는 호출 불가능
        print("static 메소드")
    }
}

// 인스턴스 생성
let obj = ClassPoint()
// 인스턴스 메소드 호출
obj.set(x : 100)
print("obj.x:\(obj.get())")

// obj.disp() 인스턴스로는 static 메소드를 호출할 수 없음
ClassPoint.disp()

// 객체 지향의 개념을 갖는 언어를 학습할 때 static의 개념을 갖는
// 멤버를 인스턴스가 호출할 수 있는지 확인

// 일정한 시간단위로 함수를 호출해서 수행해주는 인스턴스 생성
// Timer
var timer:Timer =
    Timer.scheduledTimer(timeInterval: 5, target: obj, selector: #selector(ClassPoint.get), userInfo: nil, repeats: true)

    class Temp {
        var count:Int = 0
        var msg : String = ""
        
        // init을 만들면 기본적으로 제공되는 init은 더 이상 사용할 수 없음
        init(){
            print("초기화 메소드")
        }
        // 매개변수가 1개 있는 init
        // 초기화 메소드 오버로딩 - init이 여러개
        init(msg:String){
            self.msg = msg
        }
        
        // 소멸자 메소드
        deinit{
            print("인스턴스가 소멸됨")
        }
}

// 매개변수가 없는 init을 호출
let t = Temp()
print("\(t.msg):\(t.count)")
// 매개변수가 있는 init을 호출
var obj:Temp? = Temp(msg:"Swift")
// ! 추가로 강제로 optional을 벗겨냄
print("\(obj!.msg):\(obj!.count)")

// 이 문장은 obj가 참조하는 인스턴스의 참조를 복사해서 copy에 대입
// 참조 카운트도 1 증가
// var copy = obj -> 대입시 deinit 출력 X

// 프로그램 중간에 실행하고자 할때는 메모리 정리를 실행해주어야 함
// obj에 nil을 대입하고 참조 카운트를 1 감소시킴
obj = nil

// 학생 한 명에 대한 정보를 저장할 구조체
struct Student {
    var name : String
    var number : Int
}

// 강사 클래스 - 가르치는 학생들에 대한 정보를 배열로 저장
class Teacher {
    // 번호를 자동 생성하기 위한 프로퍼티
    static var num : Int = 0
    // 학생 정보를 저장하기 위한 프로퍼티
    var students:[Student] = [Student]()
    
    // 이름을 넘겨받아서 students에 추가하는 함수
    func addStudent(name:String){
        Teacher.num = Teacher.num + 1
        let student:Student = Student(name: name, number: Teacher.num)
        students.append(student)
    }
    // 이름을 여러 개 넘겨받아서 students에 추가하는 함수 (... -> 여러개)
    func addStudents(names:String ...){
        for name in names{
            self.addStudent(name: name)
        }
    }
    // 서브스크립트 만들기
    subscript(index:Int) -> Student?{
        if index < Teacher.num {
            return self.students[index]
        }
        return nil
    }
}

// 인스턴스 한 개 생성
let teacher = Teacher()

teacher.addStudent(name: "bonnie")
teacher.addStudents(names: "genie", "sohyun")

// 2번째 데이터인 genie 이름 출력
print(teacher.students[1].name)

// 서브스크립트를 이용한 접근 (위의.students 단계를 줄임)
print(teacher[1]!.name)


class SuperClass {
    func superMethod() -> Void {
        print("상위 클래스의 메소드")
    }
}

class SubClass : SuperClass {
    func subMethod() -> Void {
        print("하위 클래스의 메소드")
    }
}

// SubClass의 인스턴스 생성
let sub = SubClass()
// SubClass에 만들지 않은 superMethod를 호출할 수 있음
sub.superMethod()
*/

class Super{
    func disp() {
        print("상위 클래스의 disp")
    }
}

class Sub : Super {
    // 메소드 오버라이딩
    override func disp() {
        print("하위 클래스의 disp")
    }
    
    func subMethod(){
        print("하위 클래스 만의 메소드")
    }
    
    // 초기화 메소드 (override 써주어야 함)
    // 매개변수가 없는 init을 만들 때는 상위 클래스에 이 생성자가 보이지 않더라도
    // override를 추가해 주어야 함
    override init() {
        
    }
    
    // 매개변수가 있는 초기화 메소드
    // 매개변수가 있을 때는 overriding 되지 않음
    init(msg:String) {
        print(msg)
    }
}

// let sub = Sub(msg: "Swift")

// 당연히 실행됨
var sup:Super = Super()

// 아무 문제없이 가능
sup = Sub()

// 양쪽의 자료형이 맞으므로 가능
var sub:Sub = Sub()

// sub = Super() // error - 형 변환없이는 대입할 수 없음

// 대입된 인스턴스가 Sub이므로 형 변환을 해도 문제가 없음
sub = sup as! Sub

// sub = Super() as! Sub // Super를 강제로 Sub으로 만들었으므로 실행 중 에러

var x : Super = Sub() // 이 상태에서는 x가 Super 소유하고 있는 것만 호출 가능
// Sub의 subMethod를 호출하고자 하면 강제 형 변환을 해야함

x.disp() // disp는 오버라이딩 메소드라서 인스턴스를 보고 자신의 메소드를 호출
// Sub의 disp를 호출

x = Super()
x.disp() // Super의 disp를 호출 
