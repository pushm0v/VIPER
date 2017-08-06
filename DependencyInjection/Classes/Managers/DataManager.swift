//
//  DataManager.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/6/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol IDataManager: class {
    func saveSomeString(value: String)
    func loadSomeString() -> String?
    func clear()
}

class DataManager: IDataManager {
    let userDefaults: UserDefaults
    
    let StringKey: String = "STRING_KEY_DUMMY"
    
    init() {
        userDefaults = UserDefaults()
    }
    
    func saveSomeString(value: String)
    {
        userDefaults.set(value, forKey: StringKey)
    }
    
    func loadSomeString() -> String?
    {
        return userDefaults.string(forKey: StringKey)
    }
    
    func clear() {
        userDefaults.removeObject(forKey: StringKey)
    }
}
