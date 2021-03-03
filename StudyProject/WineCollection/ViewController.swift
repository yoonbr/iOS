//
//  ViewController.swift
//  WineCollection
//
//  Created by boreum yoon on 2021/03/03.
//

import UIKit

class ViewController: UIViewController {
    
    // 컬렉션 뷰에 출력할 이미지 파일 이름 배열
    var images : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배열 초기화
        for i in 1...3{
            let imageName = String(format:"wine%02i.png", i)
            images.append(imageName)
        }
    }


}

extension ViewController : UICollisionBehaviorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //셀의 개수를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //셀의 모양을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    //셀의 크기를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //가로로 3개 배치
         let collectionViewCellWidth =
             collectionView.frame.width / 10 - 1
        
        // 가로와 세로 크기 설정
        return CGSize(width: 100, height: 160)
        
    }
    
    //상하좌우 여백을 설정하는 메소드 - Margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //패딩
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //셀을 선택했을 때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.cyan.cgColor
        cell?.layer.borderWidth = 3.0
    }
}
