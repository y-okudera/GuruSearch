//
//  UITableView+.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Failed to instantiate cell. (identifier: \(T.identifier))")
        }
        return cell
    }

    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        self.register(
            .init(nibName: cellType.identifier, bundle: .main),
            forCellReuseIdentifier: cellType.identifier
        )
    }
}
