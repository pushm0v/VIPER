//
//  HomeAssembly.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation
import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeModule.self){(r, appRouter: IAppRouter)  in
            return HomeModule(router: appRouter)
        }
        
        container.register(IHomeWireframe.self){(r, appRouter: IAppRouter) -> IHomeWireframe in
            return HomeWireframe(router: appRouter)
        }
        
        container.register(IHomeInteractor.self) { r in
            let manager = r.resolve(IDummyManager.self)!
            let interactor = HomeInteractor(dummyManager: manager)
            
            return interactor
        }
        
        container.register(IHomePresenter.self) { (r, appRouter: IAppRouter, view: IHomeView) in
            let wireframe = r.resolve(IHomeWireframe.self, argument: appRouter)!
            let interactor = r.resolve(IHomeInteractor.self)!
            let presenter = HomePresenter(view: view,
                                           wireframe: wireframe,
                                           interactor: interactor)
            interactor.delegate = presenter
            return presenter
        }
        
        
        container.register(HomeViewController.self) { (r, appRouter: IAppRouter) in
            let view = HomeViewController()
            let presenter = r.resolve(IHomePresenter.self, arguments: appRouter, view as IHomeView)!
            view.presenter = presenter
            return view
        }
    }
}
