//
//  WebBrowserPresenter.swift
//  GuruSearch
//
//  Created by yuoku on 23/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// View -> Presenter
///
/// ViewからPresenterへの処理依頼を定義
protocol WebBrowserPresentable: AnyObject {
    var view: WebBrowserView? { get }
    var router: WebBrowserWireframe { get }
    var interactor: WebBrowserUsecaseInput { get }
    var initialURL: URL { get }
    func viewDidLoad()
}

/// Interactor -> Presenter
///
/// InteractorからPresenterへの処理結果の通知を定義
protocol WebBrowserUsecaseOutput: AnyObject {
    // None
}

final class WebBrowserPresenter: WebBrowserPresentable {
    weak var view: WebBrowserView?
    let router: WebBrowserWireframe
    let interactor: WebBrowserUsecaseInput
    let initialURL: URL
    
    init(view: WebBrowserView?, router: WebBrowserWireframe, interactor: WebBrowserUsecaseInput, initialURL: URL) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.initialURL = initialURL
    }

    func viewDidLoad() {
        let request = URLRequest(url: initialURL)
        print("request", request)
        view?.load(urlRequest: request)
    }
}

extension WebBrowserPresenter: WebBrowserUsecaseOutput {
    // None
}
