import UIKit

// UIViewController를 상속받은 클래스
class ViewController: UIViewController {
    
    // 3. Dictionary로 선언, 형변환 사용
    let changeImg:[Bool:UIImage] = [
        true:UIImage(named: "wine01.png")!,
        false:UIImage(named: "wine02.png")!
    ]
    
    // 1. 아울렛 변수 입력
    @IBOutlet var myImg: UIImageView!
    
    // 뷰가 다 로드 된 지점에서 어떤 작업 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 변경되는 이미지를 가져와서 변수 선언 (현재 접근할 수 있는 파일의 이름을 가져옴)
        // var ii = UIImage(named: "wine02.png")
        
        // imageView의 이미지를 ii 이미지로 변경
        // myImg.image = ii
        
        // changeImg의 상태가 false 상태일 때로 예시 들기
        // myImg.image = changeImg[false]
    }
    
    // 2. 메소드 입력
    // 2-1 버튼을 누르면 확대
    @IBAction func zoomIn(_ sender: UIButton) {
        print("push the button")
    }
   
    // 2-2 스위치를 누르면 사진이 바뀜
    @IBAction func changeSwitch(_ sender: UISwitch) {
        // 매개변수 sender.isOn - 스위치의 상태 표시 (true, false)
        // print(sender.isOn)
        
        // 4. ender.isOn의 상태가 true, false일때 작동시키기
        myImg.image = changeImg[sender.isOn]
    }
}
