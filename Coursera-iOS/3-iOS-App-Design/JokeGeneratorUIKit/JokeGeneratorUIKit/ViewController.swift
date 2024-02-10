import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = "Quote Generator"
        
        // Image View
        let imageView = UIImageView(image: UIImage(systemName: "quote.bubble"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = view.center
        view.addSubview(imageView)
        
        // Generate Random Quote Button
//        let generateRandomQuoteButton = UIButton(type: .system)
//        generateRandomQuoteButton.setTitle("Generate Random Quote", for: .normal)
//        generateRandomQuoteButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        generateRandomQuoteButton.setTitleColor(.white, for: .normal)
//        generateRandomQuoteButton.backgroundColor = .blue
//        generateRandomQuoteButton.layer.cornerRadius = 10
//        generateRandomQuoteButton.addTarget(self, action: #selector(didTapGenerateRandomQuote), for: .touchUpInside)
//        
        // Generate By Category Button
//        let generateByCategoryButton = UIButton(type: .system)
//        generateByCategoryButton.setTitle("Generate By Category", for: .normal)
//        generateByCategoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        generateByCategoryButton.setTitleColor(.white, for: .normal)
//        generateByCategoryButton.backgroundColor = .green
//        generateByCategoryButton.layer.cornerRadius = 10
//        generateByCategoryButton.addTarget(self, action: #selector(didTapGenerateByCategory), for: .touchUpInside)
//        
        // Generate Random Joke Button
        let generateRandomJokeButton = UIButton(type: .system)
        generateRandomJokeButton.setTitle("Generate Random Joke", for: .normal)
        generateRandomJokeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        generateRandomJokeButton.setTitleColor(.white, for: .normal)
        generateRandomJokeButton.backgroundColor = .orange
        generateRandomJokeButton.layer.cornerRadius = 10
        generateRandomJokeButton.addTarget(self, action: #selector(didTapGenerateRandomJoke), for: .touchUpInside)
        
        // Select Joke Category Button
        let selectJokeCategoryButton = UIButton(type: .system)
        selectJokeCategoryButton.setTitle("Select Joke Category", for: .normal)
        selectJokeCategoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        selectJokeCategoryButton.setTitleColor(.white, for: .normal)
        selectJokeCategoryButton.backgroundColor = .purple
        selectJokeCategoryButton.layer.cornerRadius = 10
        selectJokeCategoryButton.addTarget(self, action: #selector(didTapSelectJokeCategory), for: .touchUpInside)
        
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [ generateRandomJokeButton, selectJokeCategoryButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        // Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
