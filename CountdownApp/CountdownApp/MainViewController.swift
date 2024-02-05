//
//  MainViewController.swift
//  CountdownApp
//
//  Created by Nikolai Maksimov on 05.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    enum Section {
        case main // one section for table view
    }
    
    // MARK: Private Properties
    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, Int>!
    
    private var timer: Timer!
    private var startInterval = 10 // seconds
    
    // MARK: Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTableView()
    }
}

extension MainViewController {
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}
