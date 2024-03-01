//
//  RandomJokeViewController.swift
//  JokeGeneratorUIKit
//

import UIKit

class RandomJokeViewController: UIViewController {

    // MARK: - Properties
    
    private var currentJoke: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.jokeLabel.text = self?.currentJoke
            }
        }
    }
    
    private let jokeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var generateNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate New", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(fetchRandomJoke), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchRandomJoke()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Random Joke"
        
        view.addSubview(jokeLabel)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(generateNewButton)
        generateNewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generateNewButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 20),
            generateNewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateNewButton.widthAnchor.constraint(equalToConstant: 150),
            generateNewButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func fetchRandomJoke() {
        JokeService.fetchRandomJoke { [weak self] result in
            switch result {
            case .success(let joke):
                self?.currentJoke = joke
            case .failure(let error):
                print("Error fetching random joke: \(error)")
            }
        }
    }
}
