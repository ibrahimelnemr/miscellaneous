
import UIKit

class RandomJokeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let jokeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var regenerateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Regenerate", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(regenerateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private var currentJoke: String? {
        didSet {
            jokeLabel.text = currentJoke
        }
    }
    
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
        NSLayoutConstraint.activate([
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            jokeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        view.addSubview(regenerateButton)
        NSLayoutConstraint.activate([
            regenerateButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 20),
            regenerateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regenerateButton.widthAnchor.constraint(equalToConstant: 120),
            regenerateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func fetchRandomJoke() {
        JokeService.fetchRandomJoke { [weak self] result in
            switch result {
            case .success(let joke):
                self?.currentJoke = joke
            case .failure(let error):
                print("Error fetching random joke: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func regenerateButtonTapped() {
        fetchRandomJoke()
    }
}
