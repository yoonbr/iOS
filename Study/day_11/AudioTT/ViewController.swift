//
//  ViewController.swift
//  AudioTT
//
//  Created by boreum yoon on 2021/11/05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    // 1. 아웃렛, 액션 변수 선언
    @IBOutlet var myProgress: UIProgressView!
    
    @IBOutlet var currLB: UILabel!
    
    @IBOutlet var endLB: UILabel!
    
    @IBOutlet var myImg: UIImageView!
    
    // 7. 녹음 관련 UI 가져오기 - 재생 상태, 녹음 시간
    @IBOutlet var statusLB: UILabel!
    @IBOutlet var recordLB: UILabel!
    
    // 2. 음원 가져오기 - 녹음해서 음원 바꿀 수 있도록
    var aUrl: URL!
    
    var currUrl: URL!
    
    // 2-2. 플레이어 가져오기 (import AVFoundation)
    var aPlayer: AVAudioPlayer!
    
    // 3-2. Timer - objc function
    var currTimer: Timer!
    
    let playSelector = #selector(updatePlayTime)
    
    let recSelector = #selector(updateRecTime)
    
    @objc func updatePlayTime() {
        // 3-3. 현재 지나가고 있는 시간을 currLB에 표시
        currLB.text = secToStr(aPlayer.currentTime)
        // 4. progress view
        // 끝 시간 나누기 현재 지나가는 시간을 나누어 progress bar 표시
        myProgress.progress = Float(aPlayer.currentTime/aPlayer.duration)
    }
    
    @objc func updateRecTime() {
        // 3-3. 현재 지나가고 있는 시간을 currLB에 표시
        recordLB.text = secToStr(aRecorder.currentTime)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2-1. 앱에 있는 리소스의 경로 가져오기 - bundle (파일명:, 확장자:)
        aUrl = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: ".mp3")
        currUrl = aUrl
    
    }
    
    // 3-1. 초를 분으로 변경하는 함수 생성 (시간)
    func secToStr(_ time:TimeInterval) -> String {
        // return "time"
        let mm = Int(time / 60)
        let ss = Int(time) % 60
        return "\(mm) : \(ss)"
    }

    @IBAction func goPlay(_ sender: Any) {
        
        // 타이머가 최초 실행일때만 실행
        if currTimer == nil {
            // 2-3. 음원을 가져와서 변경해줘야함 음원이 없으면 예외처리 필수 (do-catch)
            // AVAudioPlayer 는 예외처리 필수
            do {
                aPlayer = try AVAudioPlayer(contentsOf: currUrl) // 시도했는데 실패하면 캐치로 감
                // 6-1. 플레이어 delegate 위임
                aPlayer.delegate = self
                // 볼륨값 초기화, storyboard의 UISlider 값과 일치하게 고정
                aPlayer.volume = 1
            } catch let err as NSError {
                print("error : \(err)")
            }
            
            // 3. 시작, 끝 시간(전체시간) 표시하기
            // endLB.text = "\(aPlayer.duration)" // 초 단위로 출력 됨
            endLB.text = secToStr(aPlayer.duration)
            
            // 3-4. 1초씩 증가하게 스레드 실행
            currTimer = Timer.scheduledTimer(
                timeInterval: 0.1,
                target: self,
                selector: playSelector,
                userInfo: nil,
                repeats: true
            )
        }
        
        // 2-4. 음원 실행
        aPlayer.play()
        myImg.image = UIImage(named: "albumCover.png")
        
        // 3. 시작, 끝 시간(전체시간) 표시하기
        // endLB.text = "\(aPlayer.duration)" // 초 단위로 출력 됨
        endLB.text = secToStr(aPlayer.duration)
        
        // 3-4. 1초씩 증가하게 스레드 실행
        currTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: playSelector,
            userInfo: nil,
            repeats: true
        )
        
        
    }
    
    @IBAction func goPause(_ sender: Any) {
        // 2-5. 일시정지
        aPlayer.pause()
        
    }
    
    @IBAction func goStop(_ sender: Any) {
        
        if currTimer != nil {
            // 타이머 invalidate
            currTimer.invalidate()
            // 2-6. 정지
            aPlayer.stop()
            // progressbar, 시작시간을 정지누를 때 초기화시킴
            updatePlayTime()
            // 2-7. 정지 후 처음으로 다시 돌아가서 재생 (시작 위치 0초로 변경)
            aPlayer.currentTime = 0
        }
        
        currTimer = nil
    }
    
    
    
    // 5. 음량 조절 - slider에서 직접 값 받아옴
    @IBAction func volumeChange(_ sender: UISlider) {
        aPlayer.volume = sender.value
    }
    
    // 6-2. 노래 끝날 때 호출 - delegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finish")
        
        // 6-3. timer 초기화
        currTimer.invalidate()
        currTimer = nil
        updatePlayTime()
    }
    
    // 7-1. recorder 변수 생성 - 녹음 제어
    var aRecorder: AVAudioRecorder!
    
    // 7-2. 녹음 경로 변수
    var rUrl: URL!
    
    // 7. 녹음관련 UI 가져오기
    @IBAction func recordGo(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "record" {
            
            sender.setTitle("stop", for: UIControl.State())
            
            // 현재 앱의 파일 경로 설정
            let dir = FileManager.default.urls(
                for: .documentDirectory,
                   in: .userDomainMask)[0]
            
            rUrl = dir.appendingPathComponent("record.m4a")
            
            // 녹음 품질 - 애플 장비에서 오는 값, 압축 기술, 음질 단계
            let recSetting = [
                AVFormatIDKey:NSNumber(value: kAudioFormatAppleLossless),
                AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue,
                AVEncoderBitRateKey:320000,
                AVNumberOfChannelsKey:2,
                AVSampleRateKey:44100.0
            ] as [String:Any]
            
            do {
                // aRecorder를 저장 경로와 세팅으로 정의 후, 예외처리 do-catch
                aRecorder = try AVAudioRecorder(url: rUrl, settings: recSetting)
            } catch let err as NSError {
                print("error : \(err)")
            }
            // 7-3. recorder의 delegate 위임
            aRecorder.delegate = self
            
            // 7-4. 녹음을 외부에서 가져오는 기능을 세팅
            // 녹음 개체 연결 - 예외처리
            let session = AVAudioSession.sharedInstance()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                // 녹음 기능 활성화
                try AVAudioSession.sharedInstance().setActive(true)
                try session.setCategory(AVAudioSession.Category.playAndRecord)
                try session.setActive(true)
                
            } catch let err as NSError {
                print("connect error : \(err)")
            }
            
            // 7-5. 설정 완료 후 녹음 진행
            aRecorder.record()
            
            // 9. 녹음 시간 확인
            currTimer = Timer.scheduledTimer(
                timeInterval: 0.1,
                target: self,
                selector: recSelector,
                userInfo: nil,
                repeats: true
            )
        }
        
        else {
            
            // 음원 파일 정지와 똑같이 실행
            if currTimer != nil {
                // 타이머 invalidate
                currTimer.invalidate()
                // 정지
                aRecorder.stop()
                // 타이머 새로 시작 위해 0으로 초기화 
                updateRecTime()
            }
            
            // 7-6. 녹음 중지
            sender.setTitle("record", for: UIControl.State())
            
        }
    }
    
    @IBAction func soundChange(_ sender: UISwitch) {
        // 8. 녹음한 파일 듣기
        if sender.isOn { // 녹음파일일때는 바꾸기
//            let dir = FileManager.default.urls(
//                for: .documentDirectory,
//                   in: .userDomainMask)[0]
//
//            aUrl = dir.appendingPathComponent("record.m4a")
            
            // aUrl = rUrl
           currUrl = aUrl
            statusLB.text = "노래파일"
            
        } else { // 재생 파일
            // currUrl을 따로 잡아서 사용해도 됨
            // aUrl = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: ".mp3")
            currUrl = rUrl
            statusLB.text = "녹음파일"
        }
    }
    
}


