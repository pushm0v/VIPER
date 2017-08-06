//
//  CommonAssembly.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation
import Swinject

class CommonAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(IAppRouter.self) {(r) in
            return AppRouter.sharedInstance
        }
        
//        Register common manager in here, ex :
        container.register(IDummyManager.self) {(r) in
            return DummyManager()
        }
        
        container.register(IDataManager.self) {(r) in
            return DataManager()
        }
    }
}
