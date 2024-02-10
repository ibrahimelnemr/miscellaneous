//
//  SelectJokeCategoryViewController.swift
//  JokeGeneratorUIKit
//

import UIKit

protocol SelectJokeCategoryDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class SelectJokeCategoryViewController: UIViewController {

    // MARK: - Properties
    
    weak var delegate: SelectJokeCategoryDelegate?
    
    // MARK: - UI Elements
    
    private let categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        return tableView
    }()
    
    // MARK: - Data
    
    private let categories = ["Misc", "Programming", "Pun", "Spooky", "Christmas", "Miscellaneous"]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Select Joke Category"
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        
        view.addSubview(categoriesTableView)
        categoriesTableView.frame = view.bounds
    }
}

// MARK: - UITableViewDelegate

extension SelectJokeCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let jokeByCategoryViewController = JokeByCategoryViewController(category: category)
        navigationController?.pushViewController(jokeByCategoryViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SelectJokeCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
}
