//
//  Modules.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation

public protocol IModule {
    func presentView(parameters: [String:Any])
}

public protocol Module : Product {
    var routePath : String { get }
}

public protocol Product {
    var productName : String { get }
}


public enum Products {
    case VIPERProduct
    
    public var productName: String {
        switch self {
        case .VIPERProduct:
            return "VIPER"
        }
    }
    
    public enum VIPER: Module {
        case HomeModule
        case DetailsModule
        
        public var productName: String {
            return "VIPER"
        }
        
        public var routePath: String {
            switch self {
            case .HomeModule:
                return "/viper/home"
            case .DetailsModule:
                return "/viper/details"
            }
        }
    }
}
