import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        
        title = "Joke Generator"
        
        // Image View
        let imageView = UIImageView(image: UIImage(systemName: "quote.bubble"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        // Generate Random Joke Button
        let generateRandomJokeButton = UIButton(type: .system)
        generateRandomJokeButton.setTitle("Generate Random Joke", for: .normal)
        generateRandomJokeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        generateRandomJokeButton.setTitleColor(.white, for: .normal)
        generateRandomJokeButton.backgroundColor = UIColor(red: 0.35, green: 0.67, blue: 0.80, alpha: 1.00) // Light blue color
        generateRandomJokeButton.layer.cornerRadius = 15
        generateRandomJokeButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // Add padding
        generateRandomJokeButton.addTarget(self, action: #selector(didTapGenerateRandomJoke), for: .touchUpInside)
        generateRandomJokeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Select Joke Category Button
        let selectJokeCategoryButton = UIButton(type: .system)
        selectJokeCategoryButton.setTitle("Select Joke Category", for: .normal)
        selectJokeCategoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        selectJokeCategoryButton.setTitleColor(.white, for: .normal)
        selectJokeCategoryButton.backgroundColor = UIColor(red: 0.35, green: 0.67, blue: 0.80, alpha: 1.00) // Light blue color
        selectJokeCategoryButton.layer.cornerRadius = 15
        selectJokeCategoryButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // Add padding
        selectJokeCategoryButton.addTarget(self, action: #selector(didTapSelectJokeCategory), for: .touchUpInside)
        selectJokeCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [imageView, generateRandomJokeButton, selectJokeCategoryButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120), // Adjust size of the icon
            imageView.heightAnchor.constraint(equalToConstant: 120), // Adjust size of the icon
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40), // Adjust vertical position of the stack view
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Actions

    @objc private func didTapGenerateRandomJoke() {
        let randomJokeViewController = RandomJokeViewController()
        navigationController?.pushViewController(randomJokeViewController, animated: true)
    }
    
    @objc private func didTapSelectJokeCategory() {
        let selectJokeCategoryViewController = SelectJokeCategoryViewController()
        navigationController?.pushViewController(selectJokeCategoryViewController, animated: true)
    }
}
