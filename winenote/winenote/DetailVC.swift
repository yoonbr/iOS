//
//  DetailVC.swift
//  winenote
//
//  Created by boreum yoon on 2021/03/16.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblWineName: UILabel!
    
    @IBOutlet weak var noteView: UITableView!
    
    var wine: Wine!
    // var noteList = Array<Note>()
    let word = ["💢💢💢💢💢","^^","🙃","🔥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = wine.winename
        
        imageView.image = wine.image
        lblWineName.text = wine.winename
        
        // tableview delegate, datasource
        noteView.delegate = self
        noteView.dataSource = self

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        // 데이터 가져올 URL
//        let listUrl = "http://172.30.1.5/note/notelist/\(wine.winenum)"
//        let updateUrl = "http://172.30.1.5/wine/updatedate"
//
//            if appDelegate.updatedate == nil {
//                print("Load Data")
//                // 데이터 가져와서 출력 - GET
//                let request = AF.request(listUrl, method: .get, encoding: JSONEncoding.default, headers: [:])
//                request.responseJSON {
//                    response in
//                    if let jsonObject = response.value as? [String:Any] {
//                        let list = jsonObject["list"] as! NSArray
//                        for index in 0...(list.count - 1) {
//                            let noteDict = list[index] as! NSDictionary
//                            // Wine 객체 생성
//                            var note = Note()
//                            note.winenum = ((noteDict["winenum"] as! NSNumber).intValue)
//                            note.notenum = ((noteDict["notemum"] as! NSNumber).intValue)
//                            note.nickname = noteDict["nickname"] as? String
//                            note.price = ((noteDict["price"] as? NSNumber)?.intValue)
//                            note.firstword = noteDict["firstword"] as? String
//                            note.secondword = noteDict["secondword"] as? String
//                            note.notedate = noteDict["notedate"] as? String
////
////                            // 이미지 가져오기
////                            let imageurl = URL(string:"http://172.30.1.5/img/\(wine.wineimg!)")
////                            let imageData = try?Data(contentsOf: imageurl!)
////                            wine.image = UIImage(data: imageData!)
////                            self.wineList.append(wine)
//                        }
//                        NSLog("데이터 저장 성공")
//                    }
//
//                    self.noteTableView.reloadData()
//
//                    // update 시간 받아오기
//                    let updateRequest = AF.request(updateUrl, method: .get, encoding: JSONEncoding.default, headers: [:])
//                    updateRequest.responseJSON { response in
//                        if let jsonObject = response.value as? [String:Any] {
//                            let result = jsonObject["result"] as? String
//                            appDelegate.updatedate = result
//                        }
//                    }
//                }
//            } else {
//                // 업데이트 한 시간이 존재하는 경우
//                let updateRequest = AF.request(updateUrl, method: .get, encoding: JSONEncoding.default, headers: [:])
//                updateRequest.responseJSON { response in
//                    if let jsonObject = response.value as? [String:Any] {
//                        let result = jsonObject["result"] as? String
//                        // 내가 가지고 있는 업데이트 시간과 같은 경우 현재 데이터만 다시 출력
//                        if appDelegate.updatedate == result {
//                            self.noteTableView.reloadData()
//                        } else {
//                        // else - 서버의 데이터 다시 읽어서 출력
//                            let request = AF.request(listUrl, method: .get, encoding: JSONEncoding.default, headers: [:])
//                            request.responseJSON {
//                                response in
//                                if let jsonObject = response.value as? [String:Any] {
//                                    let list = jsonObject["list"] as! NSArray
//
//                                    // 기존의 데이터를 삭제
//                                    self.noteList.removeAll()
//
//                                    for index in 0...(list.count - 1) {
//                                        let noteDict = list[index] as! NSDictionary
//                                        // Wine 객체 생성
//                                        var note = Note()
//                                        note.winenum = ((noteDict["winenum"] as! NSNumber).intValue)
//                                        note.notenum = ((noteDict["notemum"] as! NSNumber).intValue)
//                                        note.nickname = noteDict["nickname"] as? String
//                                        note.price = ((noteDict["price"] as? NSNumber)?.intValue)
//                                        note.firstword = noteDict["firstword"] as? String
//                                        note.secondword = noteDict["secondword"] as? String
//                                        note.notedate = noteDict["notedate"] as? String
//                                    }
//                                    NSLog("데이터 저장 성공")
//                                }
//                                self.noteTableView.reloadData()
//
//                                // update 시간 받아오기
//                                let updateRequest = AF.request(updateUrl, method: .get, encoding: JSONEncoding.default, headers: [:])
//                                updateRequest.responseJSON { response in
//                                    if let jsonObject = response.value as? [String:Any] {
//                                        let result = jsonObject["result"] as? String
//                                        appDelegate.updatedate = result
//
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
   
    
}
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = noteView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        let oneWord = word[indexPath.row]
        
        cell.lblWord.text = oneWord
    
        return cell
    }
}
