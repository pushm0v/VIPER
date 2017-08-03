//
//  HomeINteractor.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol HomeInteractorDelegate: class {
    func didDummyTellAJoke(jokes: String)
    func didDummyJokeIsNotFunny(error: NSError?)
}

protocol IHomeInteractor: class {
    var delegate: HomeInteractorDelegate? { get set }
    func dummyGetAJoke()
}

class HomeInteractor: IHomeInteractor {
    let dummyManager: IDummyManager
    
    var delegate: HomeInteractorDelegate?
    
    init(dummyManager: IDummyManager) {
        self.dummyManager = dummyManager
    }
    
    func dummyGetAJoke() {
        self.dummyManager.doSomethingFunny(success: {(dummy) in
            self.delegate?.didDummyTellAJoke(jokes: dummy.jokes)
        }, failure: {(error) in
            self.delegate?.didDummyJokeIsNotFunny(error: nil)
        })
    }
}
