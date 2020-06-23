//
//  AreaListViewController.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

/// Presenter -> View
///
/// PresenterからViewへのUI更新を定義
protocol AreaListView: AnyObject {
    var presenter: AreaListPresentable! { get }
    var areaListProvider: AreaListProvider! { get }
    func reloadAreaList(areas: Areas)
    func showAlert(message: String)
}

final class AreaListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    var presenter: AreaListPresentable!
    var areaListProvider: AreaListProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
}

extension AreaListViewController {
    private func setup() {
        navigationItem.title = "AreaList".localized()
        tableView.registerCell(cellType: AreaTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = areaListProvider
        
        startAnimating()
        presenter.viewDidLoad()
    }
}

extension AreaListViewController: AreaListView {
    func reloadAreaList(areas: Areas) {
        stopAnimating()
        areaListProvider.set(gareaLarge: areas.gareaLarge)
        tableView.reloadData()
    }

    func showAlert(message: String) {
        stopAnimating()
        UIAlertController.alert(on: self, message: message)
    }
}

extension AreaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectArea(gareaLarge: areaListProvider.gareaLarge[indexPath.row])
    }
}
