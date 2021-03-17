//
//  ToDoListVC.swift
//  ToDoCoreData
//
//  Created by boreum yoon on 2021/03/17.
//

import UIKit

import CoreData

class ToDoListVC: UITableViewController {
    //데이터 소스 역할을 할 배열 변수
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    //Core 데이터에서 ToDo Entity의 모든 데이터를 리턴해주는 함수
    func fetch() -> [NSManagedObject] {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 3. 요청 객체 생성 - Entity를 변경해가면서 가져오면 됩니다.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
         // 정렬 속성 설정
         let sort = NSSortDescriptor(key: "runtime", ascending: false)
         fetchRequest.sortDescriptors = [sort]

        
        // 4. 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
    //CoreData 의 ToDo Entity에 데이터를 삽입하는 메소드
    func save(title: String, contents: String, runtime: Date) -> Bool {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 관리 객체 생성 & 값을 설정
        let object = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        // 4. 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가한다.
        do {
            //실제 데이터 저장
            try context.save()
            //self.list.append(object)
            //데이터 목록에도 저장
            self.list.insert(object, at: 0)
            //데이터 다시 호출하기
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    //이벤트 처리 메소드를 직접 생성해서 연결하는 경우 @objc를 붙여야 합니다.
    //+ 버튼을 눌렀을 때 호출되는 메소드
    @objc func add(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toDoInputViewController = storyboard.instantiateViewController(withIdentifier: "ToDoInputVC") as! ToDoInputVC
        self.present(toDoInputViewController, animated: false)
    }
    
    //실제 데이터를 삭제해주는 메소드
    func delete(object: NSManagedObject) -> Bool{
            // 1. 앱 델리게이트 객체 참조
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // 2. 관리 객체 컨텍스트 참조
            let context = appDelegate.persistentContainer.viewContext
            
            // 3. 컨텍스트로부터 해당 객체 삭제
            context.delete(object)
            
            // 4. 영구 저장소에 커밋한다.
            do {
                try context.save()
                return true
            } catch {
                context.rollback()
                return false
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do List"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.02, green: 0.02, blue: 0.50, alpha: 1.0)
        
        /*
        // 두 줄 짜리 레이블을 배치
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.textColor = UIColor.white
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "UICustomizing\nNavigationBar"
        
        self.navigationItem.titleView = nTitle
        */
        
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        self.navigationItem.titleView = imageView
        

        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 해당하는 데이터 가져오기
        let record = self.list[indexPath.row]
        //ToDo Entity의 각 속성 가져오기
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        // 셀을 생성하고 값을 대입한다.
        let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let object = self.list[indexPath.row] // 삭제할 대상 객체
            if self.delete(object: object) {
                // 코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
                self.list.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }

}
