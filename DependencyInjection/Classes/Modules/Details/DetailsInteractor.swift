//
//  HomeINteractor.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol DetailsInteractorDelegate: class {
    func didSuccessGetData(value: String)
    func didFailureGetData(error: NSError?)
}

protocol IDetailsInteractor: class {
    var delegate: DetailsInteractorDelegate? { get set }
    func getStringFromStorage()
    func saveStringToStorage(value: String)
}

class DetailsInteractor: IDetailsInteractor {
    let dummyManager: IDummyManager
    let dataManager: IDataManager
    
    var delegate: DetailsInteractorDelegate?
    
    init(dummyManager: IDummyManager, dataManager: IDataManager) {
        self.dummyManager = dummyManager
        self.dataManager = dataManager
    }
    
    func getStringFromStorage() {
        guard let string = self.dataManager.loadSomeString() else {
            self.delegate?.didFailureGetData(error: nil)
            return
        }
        
        self.delegate?.didSuccessGetData(value: string)
    }
    
    func saveStringToStorage(value: String) {
        self.dataManager.saveSomeString(value: value)
    }
}
