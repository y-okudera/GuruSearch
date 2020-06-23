//
//  WebBrowserInteractor.swift
//  GuruSearch
//
//  Created by yuoku on 23/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// Presenter -> Interactor
///
/// PresenterからInteractorへの処理依頼を定義
protocol WebBrowserUsecaseInput {

    var output: WebBrowserUsecaseOutput? { get }

    // None
}

final class WebBrowserInteractor: WebBrowserUsecaseInput {
    weak var output: WebBrowserUsecaseOutput?

    // None
}
