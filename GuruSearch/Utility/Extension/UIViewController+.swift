//
//  UIViewController+.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

// MARK: - NVActivityIndicatorViewable
extension UIViewController: NVActivityIndicatorViewable {}

extension UIViewController {
    
    // MARK: - ViewController Instantiate
    
    /// StoryboardからViewControllerのインスタンスを生成する
    ///
    /// - Precondition: ViewControllerクラスの名称とStoryboardのファイル名、Storyboard IDが同じである前提
    ///
    /// - Note: ex) LoginViewController.swift, LoginViewController.storyboard, Storyboard ID: LoginViewController
    class func instantiate<T: UIViewController>() -> T {
        let viewControllerName = String(describing: T.self)
        let viewController: T = .instantiate(storyboardName: viewControllerName, identifier: viewControllerName)
        return viewController
    }
    
    class func instantiate<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: T.self))
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to instantiate \(identifier). storyboardName is \(storyboardName).")
        }
        return viewController
    }
    
    // MARK: - Current ViewController
    
    /// 現在表示中のViewControllerを取得する
    static var current: UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        if let rootViewController = keyWindow?.rootViewController {
            return findCurrent(controller: rootViewController)
        }
        return nil
    }
}

private extension UIViewController {
    
    static func findCurrent(controller: UIViewController) -> UIViewController {
        if let presentedViewController = controller.presentedViewController {
            return findCurrent(controller: presentedViewController)
        }
        if let splitViewController = controller as? UISplitViewController, let first = splitViewController.findFirst() {
            return findCurrent(controller: first)
        }
        if let navigationController = controller as? UINavigationController, let top = navigationController.findTop() {
            return findCurrent(controller: top)
        }
        if let tabBarController = controller as? UITabBarController, let selected = tabBarController.findSelected() {
            return findCurrent(controller: selected)
        }
        return controller
    }
}

private extension UISplitViewController {
    func findFirst() -> UIViewController? {
        if let first = viewControllers.first, !viewControllers.isEmpty {
            return first
        }
        return nil
    }
}

private extension UINavigationController {
    func findTop() -> UIViewController? {
        if let top = topViewController, !viewControllers.isEmpty {
            return top
        }
        return nil
    }
}

private extension UITabBarController {
    func findSelected() -> UIViewController? {
        if let selected = selectedViewController, (viewControllers?.count ?? 0) > 0 {
            return selected
        }
        return nil
    }
}
