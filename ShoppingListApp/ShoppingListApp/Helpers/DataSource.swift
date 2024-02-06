//
//  DataSource.swift
//  ShoppingListApp
//
//  Created by Nikolai Maksimov on 06.02.2024.
//

import UIKit

class DataSource: UITableViewDiffableDataSource<Category, Item> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if Category.allCases[section] == .shoppingCart {
            return "🛒" + Category.allCases[section].rawValue
        } else {
            return Category.allCases[section].rawValue // "Running"
        }
    }
    
    // каждая строка таблицы становится доступна для редактирования
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Удаление строк из таблицы и списка
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // 1. получить текущий снимок (snapshot)
            var snapshot = self.snapshot()
            
            // 2. получить товар используя идентификатор товара
            if let item = itemIdentifier(for: indexPath) {
                // 3. удалить элемент из моментального снимка (из snapshot)
                snapshot.deleteItems([item])
                // 4. применить изменения
                 apply(snapshot, animatingDifferences: true)
            }
        }
    }
}
