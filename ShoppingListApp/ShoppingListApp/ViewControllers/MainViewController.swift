//
//  MainViewController.swift
//  ShoppingListApp
//
//  Created by Nikolai Maksimov on 06.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var tableView: UITableView!
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }


}

extension MainViewController {
    
    private func commonInit() {

        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .gray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}

