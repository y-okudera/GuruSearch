//
//  AreaListProvider.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class AreaListProvider: NSObject {
    private(set) var gareaLarge: [GareaLarge]

    init(gareaLarge: [GareaLarge]) {
        self.gareaLarge = gareaLarge
    }

    func set(gareaLarge: [GareaLarge]) {
        self.gareaLarge = gareaLarge
    }
}

extension AreaListProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gareaLarge.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AreaTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = self.gareaLarge[indexPath.row].areanameL
        return cell
    }
}
