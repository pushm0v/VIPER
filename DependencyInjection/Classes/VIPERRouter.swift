//
//  VIPERRouter.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

class VIPERRouter: IProductRouter {
    
    let router: IAppRouter
    
    let modules: [String: (IAppRouter) -> IModule] = [
        Products.VIPER.HomeModule.routePath: { HomeModule(router: $0) },
        Products.VIPER.DetailsModule.routePath: { DetailsModule(router: $0) }
    ]
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentModule(module: Module, parameters: [String : Any]) {
        if let moduleConstructor = modules[module.routePath] {
            let module = moduleConstructor(router)
            module.presentView(parameters: parameters)
        }
    }
}
