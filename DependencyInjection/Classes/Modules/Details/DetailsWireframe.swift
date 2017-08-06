//
//  HomeWireframe.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol IDetailsWireframe: class {
    func presentView(parameters: [String : Any])
}

class DetailsWireframe: IDetailsWireframe {
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentView(parameters: [String : Any]) {
        let view = router.resolver.resolve(DetailsViewController.self, arguments: router, parameters)!
        router.displayView(view: view, animateDismiss: false, animateDisplay: true)
    }
}
