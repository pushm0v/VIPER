//
//  HomeModule.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

class DetailsModule: IModule {
    
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentView(parameters: [String : Any]) {
        let wireframe = router.resolver.resolve(IDetailsWireframe.self, argument: router)!
        wireframe.presentView(parameters: parameters)
    }
}
