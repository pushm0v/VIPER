//
//  HomePresenter.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol IHomePresenter: class {
    func jokes()
    func details()
}

class HomePresenter: IHomePresenter {
    let wireframe: IHomeWireframe
    let interactor: IHomeInteractor
    weak var view: IHomeView?
    
    init(view: IHomeView, wireframe: IHomeWireframe, interactor: IHomeInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func jokes() {
        self.view?.showJoke(joke: "Wait 2 seconds")
        self.interactor.dummyGetAJoke()
    }
    
    func details() {
        self.wireframe.presentDetailsView(parameters: [
            VIPERConstants.StringToSave : "This is a bad joke"
            ])
    }
}

extension HomePresenter: HomeInteractorDelegate {
    func didDummyTellAJoke(jokes: String) {
        self.view?.showJoke(joke: jokes)
    }
    
    func didDummyJokeIsNotFunny(error: NSError?) {
        self.view?.showError(error: error)
    }
}
