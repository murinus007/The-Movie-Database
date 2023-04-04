//
//  DataService.swift
//  Movie
//
//  Created by Alex Serhiiev on 22.03.2023.
//

import Foundation
import RealmSwift

class DataService {
    
    static var shared: DataService = {
        let instance = DataService()
        return instance
    }()
    
    let realm = try! Realm()
    
    func objectExist (id: Int) -> Bool {
        return realm.object(ofType: DataModel.self, forPrimaryKey: id) != nil
    }
    
    func saveData(data: DataModel) {
        if objectExist(id:data.id) {
            deleteData(data: data)
        } else {
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    func getData() -> [DataModel] {
        var array: [DataModel] = []
        let data = realm.objects(DataModel.self)
        for element in data.elements {
            array.append(element)
        }
        return array
    }
    
    func deleteData(data: DataModel) {
        if let obj = realm.object(ofType: DataModel.self, forPrimaryKey: data.id)
        { try! realm.write {
            realm.delete(obj)
        }
        }
    }
    
}

