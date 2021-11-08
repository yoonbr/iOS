//
//  ViewController.swift
//  AudioTT
//
//  Created by boreum yoon on 2021/11/05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // 1. 아웃렛, 액션 변수 선언
    @IBOutlet var myProgress: UIStackView!
    
    @IBOutlet var currLB: UILabel!
    
    @IBOutlet var endLB: UILabel!
    
    @IBOutlet var myImg: UIImageView!
    
    // 2. 음원 가져오기 - 녹음해서 음원 바꿀 수 있도록
    var aUrl: URL!
    
    // 2-2. 플레이어 가져오기 (import AVFoundation)
    var aPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2-1. 앱에 있는 리소스의 경로 가져오기 - bundle (파일명:, 확장자:)
        aUrl = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: ".mp3")
        
        // 2-3. 음원을 가져와서 변경해줘야함 음원이 없으면 예외처리 필수 (do-catch)
        // AVAudioPlayer 는 예외처리 필수
        do {
            aPlayer = try AVAudioPlayer(contentsOf: aUrl) // 시도했는데 실패하면 캐치로 감
        } catch let err as NSError {
            print("error : \(err)")
        }
    
    }
    
    // 3-1. 초를 분으로 변경하는 함수 생성 (시간)
    func secToStr(_ time:TimeInterval) -> String {
        // return "time"
        let mm = Int(time / 60)
        let ss = Int(time) % 60
        return "\(mm) : \(ss)"
    }

    @IBAction func goPlay(_ sender: Any) {
        // 2-4. 음원 실행
        aPlayer.play()
        myImg.image = UIImage(named: "albumCover.png")
        
        // 3. 시작, 끝 시간(전체시간) 표시하기
        // endLB.text = "\(aPlayer.duration)" // 초 단위로 출력 됨
        endLB.text = secToStr(aPlayer.duration)
        
    }
    
    @IBAction func goPause(_ sender: Any) {
        // 2-5. 일시정지
        aPlayer.pause()
        
    }
    
    @IBAction func goStop(_ sender: Any) {
        // 2-6. 정지
        aPlayer.stop()
        // 2-7. 정지 후 처음으로 다시 돌아가서 재생 (시작 위치 0초로 변경)
        aPlayer.currentTime = 0
    }
    
}

