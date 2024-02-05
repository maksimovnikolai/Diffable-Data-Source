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
        configureDataSource()
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
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Int>(tableView: tableView, cellProvider: { tableView, indexPath, value in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            var content = cell.defaultContentConfiguration()
            content.text = "\(value)"
            cell.contentConfiguration = content
            
            return cell
        })
        
        // set type of animation on the data source
        dataSource.defaultRowAnimation = .fade // .automatic
        
        // setup snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        // add sections
        snapshot.appendSections([.main])
        // add item's
        snapshot.appendItems([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        // apply changes to the dataSource
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
