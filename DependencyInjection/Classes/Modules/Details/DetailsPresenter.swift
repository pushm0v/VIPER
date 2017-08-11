//
//  HomePresenter.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol IDetailsPresenter: class {
    var parameters: [String : Any]? { get set }
    func getData()
    func start()
    func dismiss()
}

class DetailsPresenter: IDetailsPresenter {
    let wireframe: IDetailsWireframe
    let interactor: IDetailsInteractor
    weak var view: IDetailsView?
    var parameters: [String : Any]?
    
    init(view: IDetailsView, wireframe: IDetailsWireframe, interactor: IDetailsInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func start() {
        guard let params = parameters else { return }
        
        if let stringToSave = params[VIPERConstants.StringToSave] as? String {
            self.interactor.saveStringToStorage(value: stringToSave)
        }
    }
    
    func getData() {
        self.interactor.getStringFromStorage()
    }
    
    func dismiss() {
        self.wireframe.dismiss()
    }
}

extension DetailsPresenter: DetailsInteractorDelegate {
    func didSuccessGetData(value: String) {
        self.view?.showData(data: value)
    }
    
    func didFailureGetData(error: NSError?) {
        var message: String = ""
        if let err = error {
            message = err.localizedDescription
        }
        else {
            message = "Shomething went wrong."
        }
        self.view?.showAlert(message: message)
    }
}
