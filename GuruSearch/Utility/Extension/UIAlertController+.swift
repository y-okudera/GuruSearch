//
//  UIAlertController+.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UIAlertController {

    typealias AlertHandler = (UIAlertAction) -> Void
    typealias PromptHandler = (String?) -> Void
    private static let positiveTitle = "OK"
    private static let negativeTitle = "Cancel"

    /// OKボタンのみのアラートを表示する
    class func alert(on controller: UIViewController? = .current,
                     title: String? = "",
                     message: String,
                     handler: AlertHandler? = nil) {
        showAlert(on: controller, title: title, message: message, positiveHandler: handler)
    }

    /// [確認] OK/Cancel ボタンがあるアラートを表示する
    class func confirm(on controller: UIViewController? = .current,
                       title: String? = "",
                       message: String,
                       negativeHandler: AlertHandler? = nil,
                       positiveHandler: @escaping AlertHandler) {
        showAlert(on: controller,
                  title: title,
                  message: message,
                  negativeBtnTitle: negativeTitle,
                  negativeHandler: negativeHandler,
                  positiveHandler: positiveHandler)
    }

    /// [削除確認] OK/Cancel ボタンがあるアラートを表示する
    ///
    /// OKボタンは赤文字
    class func confirmDestructiveAction(on controller: UIViewController? = .current,
                                        title: String? = "",
                                        message: String,
                                        negativeHandler: AlertHandler? = nil,
                                        positiveHandler: @escaping AlertHandler) {
        showAlert(on: controller,
                  title: title,
                  message: message,
                  negativeBtnTitle: negativeTitle,
                  positiveBtnStyle: .destructive,
                  negativeHandler: negativeHandler,
                  positiveHandler: positiveHandler)
    }

    /// 入力欄があるアラートを表示する
    class func prompt(on controller: UIViewController? = .current,
                      title: String? = "",
                      message: String,
                      negativeHandler: AlertHandler? = nil,
                      positiveHandler: @escaping PromptHandler) {
        showPrompt(on: controller,
                   title: title,
                   message: message,
                   negativeBtnTitle: negativeTitle,
                   negativeHandler: negativeHandler,
                   positiveHandler: positiveHandler)
    }
}

private extension UIAlertController {

    /// アラートを表示する
    class func showAlert(on controller: UIViewController?,
                         title: String?,
                         message: String,
                         negativeBtnTitle: String? = nil,
                         positiveBtnTitle: String = positiveTitle,
                         positiveBtnStyle: UIAlertAction.Style = .default,
                         negativeHandler: AlertHandler? = nil,
                         positiveHandler: AlertHandler?) {

        let alertController = makeBaseAlertController(
            title: title,
            message: message,
            negativeBtnTitle: negativeBtnTitle,
            negativeHandler: negativeHandler
        )
        let positiveAction = UIAlertAction(title: positiveBtnTitle, style: positiveBtnStyle, handler: positiveHandler)
        alertController.addAction(positiveAction)
        controller?.present(alertController, animated: true, completion: nil)
    }

    /// プロンプトを表示する
    class func showPrompt(on controller: UIViewController?,
                          title: String?,
                          message: String,
                          negativeBtnTitle: String? = nil,
                          positiveBtnTitle: String = positiveTitle,
                          negativeHandler: AlertHandler? = nil,
                          positiveHandler: @escaping PromptHandler) {

        let alertController = makeBaseAlertController(
            title: title,
            message: message,
            negativeBtnTitle: negativeBtnTitle,
            negativeHandler: negativeHandler
        )
        let positiveAction = UIAlertAction(title: positiveBtnTitle, style: .default) { _ in
            guard let textField = alertController.textFields?.first else {
                assertionFailure("alertController not have textField.")
                return
            }
            positiveHandler(textField.text)
        }
        alertController.addAction(positiveAction)
        alertController.addTextField()
        controller?.present(alertController, animated: true, completion: nil)
    }

    class func makeBaseAlertController(title: String?,
                                       message: String,
                                       negativeBtnTitle: String?,
                                       negativeHandler: AlertHandler?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let negativeBtnTitle = negativeBtnTitle {
            let negativeAction = UIAlertAction(title: negativeBtnTitle, style: .cancel, handler: negativeHandler)
            alertController.addAction(negativeAction)
        }
        return alertController
    }
}
