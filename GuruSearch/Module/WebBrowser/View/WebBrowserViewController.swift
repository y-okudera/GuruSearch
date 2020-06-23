//
//  WebBrowserViewController.swift
//  GuruSearch
//
//  Created by yuoku on 23/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import WebKit

/// Presenter -> View
///
/// PresenterからViewへのUI更新を定義
protocol WebBrowserView: AnyObject {
    func load(urlRequest: URLRequest)
}

final class WebBrowserViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    var presenter: WebBrowserPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension WebBrowserViewController {
    private func setup() {
        presenter.viewDidLoad()
    }
}

extension WebBrowserViewController: WebBrowserView {
    func load(urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}
