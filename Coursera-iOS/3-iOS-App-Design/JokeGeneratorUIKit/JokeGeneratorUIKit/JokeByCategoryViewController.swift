//
//  JokeByCategoryViewController.swift
//  JokeGeneratorUIKit
//

import UIKit

class JokeByCategoryViewController: UIViewController {

    // MARK: - Properties
    
    var category: String
    
    // MARK: - UI Elements
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let jokeTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textAlignment = .center
        return textView
    }()
    
    private lazy var generateNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate New", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(generateNewJoke), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchJokeByCategory()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Joke By Category"
        
        categoryLabel.text = category
        
        view.addSubview(categoryLabel)
        view.addSubview(jokeTextView)
        view.addSubview(generateNewButton)
        view.addSubview(backButton)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        jokeTextView.translatesAutoresizingMaskIntoConstraints = false
        generateNewButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            jokeTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            jokeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            jokeTextView.bottomAnchor.constraint(equalTo: generateNewButton.topAnchor, constant: -20),
            
            generateNewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generateNewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            generateNewButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),
            generateNewButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func fetchJokeByCategory() {
        JokeService.fetchJokesByCategory(category: category) { [weak self] result in
            switch result {
            case .success(let joke):
                DispatchQueue.main.async {
                    self?.jokeTextView.text = joke
                }
            case .failure(let error):
                print("Error fetching joke: \(error)")
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func generateNewJoke() {
        fetchJokeByCategory()
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
