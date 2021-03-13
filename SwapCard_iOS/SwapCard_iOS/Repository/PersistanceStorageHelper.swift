//
//  PersistanceHelper.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 13/03/21.
//

import Foundation

protocol PerstistanceStorageHelping {
    associatedtype Item: Codable
    func saveItem(item: Item, key: String) throws
    func getItem(key: String) -> Item?
}

class PersistanceStorageHelper<T: Codable>: PerstistanceStorageHelping {
    typealias Item = T
    
    func saveItem(item: Item, key: String) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func getItem(key: String) -> Item? {
        let decoder = JSONDecoder()
        if let value = UserDefaults.standard.value(forKey: key) as? Data {
            let object = try? decoder.decode(Item.self, from: value)
            return object
        }
        return nil
    }
}
