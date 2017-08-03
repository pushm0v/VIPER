//
//  DummyManager.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol IDummyManager: class {
    func doSomethingFunny(success: @escaping (Dummy) -> Void, failure: @escaping (NSError?) -> Void)
}

class DummyManager: IDummyManager {
    
    func doSomethingFunny(success: @escaping (Dummy) -> Void, failure: @escaping (NSError?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let dummy = Dummy(jokes: "Shit happens")
            
            success(dummy)
        }
    }
}
