//
//  HomeWireframe.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

protocol IHomeWireframe: class {
    func presentView()
}

class HomeWireframe: IHomeWireframe {
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentView() {
        let view = router.resolver.resolve(HomeViewController.self, argument: router)!
        router.displayView(view: view, animateDismiss: false, animateDisplay: true)
    }
}
