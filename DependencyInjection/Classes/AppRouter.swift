//
//  AppRouter.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 7/31/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import Foundation
import Swinject

protocol IAppRouter  {
    var resolver: Resolver { get }
    
    func displayView(view: UIViewController?, animateDismiss: Bool, animateDisplay: Bool)
    func displayView(view: UIViewController?, animateDismiss: Bool, animateDisplay: Bool, completion:(() -> Void)?)
    func displayViewWithoutDismiss(view: UIViewController?,animateDisplay:Bool)
    func dismissViewFromNavigationController(animated: Bool,completion: ()->())
    
    func presentViewModally(view: UIViewController)
    func presentView(view: UIViewController, animated: Bool)
    func dismissView()
}

class AppRouter: BaseAppRouter {
    static let sharedInstance = AppRouter.createAppRouter()
    
    private static func createAppRouter() -> AppRouter {
        let rootVC = UIApplication.shared.delegate!.window!!.rootViewController! as? UINavigationController
        
        let assembler = Assembler()
        assembler.apply(assemblies: [CommonAssembly(), HomeAssembly()])
        
        let products: [String: (_ appRouter: IAppRouter) -> IProductRouter] = [
            Products.VIPERProduct.productName: { VIPERRouter(router: $0) }
        ]
        let router = AppRouter(navigationController: rootVC, assembler: assembler, products: products)
        return router
    }
}
