//
//  AddItemViewController.swift
//  ShoppingListApp
//
//  Created by Nikolai Maksimov on 07.02.2024.
//

import UIKit

final class AddItemViewController: UIViewController {
    
    private var selectedCategory: Category?
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let nameTextfield: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Enter name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let priceTextfield: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Enter price"
        tf.keyboardType = .decimalPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let saveButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Save item"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.endEditing(true)
        
        // Категория по умолчанию
        selectedCategory = Category.allCases.first
        setViews()
        pickerView.dataSource = self
        pickerView.delegate = self
        saveButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    }
    
    // Нужно добавить при вводе пустых текстовых полей, вызов AlertController'a
    @objc private func addItem() {
     
        guard let name = nameTextfield.text,
                !name.isEmpty,
              let priceText = priceTextfield.text,
                !priceText.isEmpty,
              let price = Double(priceText),
              let selectedCategory = selectedCategory else {
            print("error")
            return
        }

        let item = Item(name: name, price: price, category: selectedCategory)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension AddItemViewController: UIPickerViewDataSource {
    // количество компонентов (столбцов)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // column
    }
    // количество элементов в столбце
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

extension AddItemViewController: UIPickerViewDelegate {
    // заголовок для строк
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allCases[row]
    }
}

extension AddItemViewController {
    private func setViews() {
        view.addSubview(nameTextfield)
        view.addSubview(priceTextfield)
        view.addSubview(saveButton)
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            nameTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            nameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextfield.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            priceTextfield.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 20),
            priceTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            priceTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            priceTextfield.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: priceTextfield.bottomAnchor, constant: 20),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            pickerView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            saveButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
