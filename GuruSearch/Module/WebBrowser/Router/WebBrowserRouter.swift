//
//  WebBrowserRouter.swift
//  GuruSearch
//
//  Created by yuoku on 23/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol WebBrowserWireframe: AnyObject {
    // None
}

final class WebBrowserRouter {
    
    private weak var viewController: UIViewController?
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(initialURL: URL) -> UIViewController {
        
        let view: WebBrowserViewController = .instantiate()
        let router = WebBrowserRouter(viewController: view)
        let interactor = WebBrowserInteractor()
        
        let presenter = WebBrowserPresenter(view: view, router: router, interactor: interactor, initialURL: initialURL)
        
        // Interactorの通知先を設定
        interactor.output = presenter
        // ViewにPresenterを設定
        view.presenter = presenter
        
        return view
    }
}

extension WebBrowserRouter: WebBrowserWireframe {
    // None
}
