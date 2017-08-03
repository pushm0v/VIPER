//
//  BaseAppRouter.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 7/31/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation
import Swinject

public protocol IProductRouter : class {
    func presentModule(module: Module, parameters:[String:Any])
}

public class BaseAppRouter : IAppRouter {
    private let assembler:Assembler!
    private let products : [String:(_ appRouter:IAppRouter)->IProductRouter]
    private let navigationController:UINavigationController?
    
    init(navigationController:UINavigationController?, assembler:Assembler, products:[String:(_ appRouter:IAppRouter)->IProductRouter]){
        self.navigationController = navigationController
        self.assembler = assembler
        self.products = products
    }
    
    public var resolver: Resolver {
        return assembler.resolver
    }
    
    public func presentModule(module: Module, parameters: [String:Any]) {
        if let productConstuctor = products[module.productName] {
            let product = productConstuctor(self)
            product.presentModule(module: module, parameters: parameters)
        }
    }
    
    public func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool){
        displayView(view: view, animateDismiss:animateDismiss, animateDisplay:animateDisplay, completion:nil)
    }
    
    public func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool, completion:(() -> Void)?){
        _ = navigationController?.popViewController(animated: animateDismiss)
        if let view = view {
            navigationController?.pushViewController(view, animated: animateDisplay)
            if let completion = completion {
                completion()
            }
        }
    }
    
    public func displayViewWithoutDismiss(view:UIViewController?,animateDisplay:Bool) {
        view?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(view!, animated: true)
    }
    
    public func dismissViewFromNavigationController(animated: Bool, completion: ()->()) {
        _ = navigationController?.popViewController(animated: animated)
        completion()
    }
    
    public func presentViewModally(view: UIViewController) {
        view.modalPresentationStyle = .overCurrentContext
        navigationController?.present(view, animated: true, completion: nil)
    }
    
    public func presentView(view: UIViewController, animated: Bool) {
        if navigationController?.viewControllers.count == 1 {
            navigationController?.setViewControllers([view], animated: animated)
        }
        else {
            navigationController?.pushViewController(view, animated: animated)
        }
    }
    
    public func dismissView() {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
