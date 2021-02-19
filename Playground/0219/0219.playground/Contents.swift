import UIKit

/*
// Set 생성
var cafe = Set<String>()

// 데이터 추가
cafe.insert("Americano")
cafe.insert("Latte")
cafe.insert("HotChoco")
cafe.insert("Greentea")

// 모든 데이터 접근
for cafedrink in cafe{
    print(cafedrink)
}

// 첫번째 데이터 1개만 가져와서 출력
print(cafe.first)
*/

// 이름이 없는 튜플 생성
let user1 = ("americano", 4100)

// 이름이 있는 튜플 생성
let user2 = (name:"cafelatte", price:4500)

// 각 요소에 이름이 없으면 인덱스를 이용해서 접근
print(user1.0)

// 각 요소에 이름이 있으면 이름으로 접근이 가능
print(user2.price)

// 튜플은 한 번 할당되면 데이터를 수정할 수 없음
// user2.name = "latte" // let error

// DTO의 대용으로 사용
typealias cafeMenu = (num:Int, name:String, price:Int)

// 데이터 배열 생성
var menuList:[cafeMenu] = [cafeMenu]()

// 데이터 삽입
menuList.append((num:1, name:"Americano", price:3800))
menuList.append((num:2, name:"CafeLatte", price:4300))

for menu in menuList {
    print(menu)
}
