//
//  DataManager.swift
//  MyMemo
//
//  Created by boreum yoon on 2021/04/29.
//

import Foundation
import CoreData

class DataManager {
    // Singleton
    // 공유 인스턴스를 저장할 타입 프로퍼티 생성
    static let shared = DataManager()
    private init() {
        
    }
    
    // 속성 추가
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 메모를 데이터베이스에서 읽어오기
    // 메모를 저장할 배열을 선언 후 빈 배열로 초기화
    var memoList = [Memo]()
    
    
    // fetch - 데이터를 데이터베이스에서 읽어옴
    // fetchRequest
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        // 최근 메모가 표시되도록 날짜를 내림차순으로 정렬
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        // fetchRequest를 실행하고 데이터를 가져오기
        do {
            memoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyMemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
