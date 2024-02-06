//
//  DataSource.swift
//  ShoppingListApp
//
//  Created by Nikolai Maksimov on 06.02.2024.
//

import UIKit

class DataSource: UITableViewDiffableDataSource<Category, Item> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Category.allCases[section].rawValue
    }
}
