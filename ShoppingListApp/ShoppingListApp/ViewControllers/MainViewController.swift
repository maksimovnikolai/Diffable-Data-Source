//
//  MainViewController.swift
//  ShoppingListApp
//
//  Created by Nikolai Maksimov on 06.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: Private properties
    private var tableView: UITableView!
    private var dataSource: DataSource!

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - Private Methods
extension MainViewController {
    
    private func commonInit() {
        configureNavBar()
        configureTableView()
        configureDataSource()
    }
    
    //MARK: Configure Nav Bar
    private func configureNavBar() {
        navigationItem.title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
    }
    
    @objc
    private func toggleEditState() {
        // перевод в состояние редактирования
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        // имя кнопки в зависимости, включено ли редактирование или нет
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    //MARK: Configure Table View
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    //MARK: Configure Data Source
    private func configureDataSource() {
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            var content = cell.defaultContentConfiguration()
            content.text = "\(item.name)"
            cell.contentConfiguration = content
            
            return cell
        })
        
        dataSource.defaultRowAnimation = .fade
        
        // setup initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
        
        for category in Category.allCases {
            // отфильтровать тестовые данные [элементы] для элементов этой конкретной категории
            let items = Item.testData().filter { $0.category == category }
            snapshot.appendSections([category])
            snapshot.appendItems(items)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

