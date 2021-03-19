//
//  SideBarVC.swift
//  SideBarApplication
//
//  Created by boreum yoon on 2021/03/18.
//

import UIKit

class SideBarVC: UITableViewController {
    
    // 각 메뉴 항목의 타이틀을 위한 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지 사항", "통계", "계정관리"]
    
    // 타이틀과 같이 보여질 이미지 배열
    let icons = [UIImage(named: "icon01.png"), UIImage(named: "icon02.png"),
                 UIImage(named: "icon03.png"), UIImage(named: "icon04.png"),
                 UIImage(named: "icon05.png"), UIImage(named: "icon06.png")]
    
    // 헤더 뷰를 만들기 위한 프로퍼티
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 헤더 뷰를 위한 프로퍼티 초기화 작업
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        
        headerView.backgroundColor = UIColor.brown
        self.tableView.tableHeaderView = headerView
        
        nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        nameLabel.text = "Bonnie"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.backgroundColor = UIColor.cyan
        headerView.addSubview(nameLabel)
        
        let defaultImage = UIImage(named: "profile.jpg")
        profileImage.image = defaultImage
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        view.addSubview(self.profileImage)
        
        // 이미지 뷰의 외곽을 동그랗게 만드는 작업
        self.profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = true
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)

        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = icons[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 출력할 뷰 컨트롤러 생성
        if indexPath.row == 0 {
            let writeVC = self.storyboard?.instantiateViewController(identifier: "WriteVC")
            as! WriteVC
            let target = revealViewController()?.frontViewController as! UINavigationController
            target.pushViewController(writeVC, animated: true)
            // 메뉴 숨기기
            revealViewController()?.revealToggle(self)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
