//
//  DetailsAssembly.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation
import Swinject

class DetailsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DetailsModule.self){(r, appRouter: IAppRouter)  in
            return DetailsModule(router: appRouter)
        }
        
        container.register(IDetailsWireframe.self){(r, appRouter: IAppRouter) -> IDetailsWireframe in
            return DetailsWireframe(router: appRouter)
        }
        
        container.register(IDetailsInteractor.self) { r in
            let dummyManager = r.resolve(IDummyManager.self)!
            let dataManager = r.resolve(IDataManager.self)!
            let interactor = DetailsInteractor(dummyManager: dummyManager, dataManager: dataManager)
            
            return interactor
        }
        
        container.register(IDetailsPresenter.self) { (r, appRouter: IAppRouter, view: IDetailsView) in
            let wireframe = r.resolve(IDetailsWireframe.self, argument: appRouter)!
            let interactor = r.resolve(IDetailsInteractor.self)!
            let presenter = DetailsPresenter(view: view,
                                          wireframe: wireframe,
                                          interactor: interactor)
            interactor.delegate = presenter
            return presenter
        }
        
        
        container.register(DetailsViewController.self) { (r, appRouter: IAppRouter, parameters: [String : Any]) in
            let view = DetailsViewController()
            let presenter = r.resolve(IDetailsPresenter.self, arguments: appRouter, view as IDetailsView)!
            presenter.parameters = parameters
            view.presenter = presenter
            
            return view
        }
    }
}
