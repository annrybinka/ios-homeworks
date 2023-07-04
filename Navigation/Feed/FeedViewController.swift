import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let postTitle = PostTitle(title: "Мои лучшие рецепты")
    
    private let feedModel: FeedModelProtocol
    
    init(feedModel: FeedModelProtocol) {
        self.feedModel = feedModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let textField: UITextField = {
        let view = UITextField()
        view.placeholder = "Введите слово"
        view.text = "Hello"
        view.backgroundColor = .systemGray6
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 18)
        view.borderStyle = UITextField.BorderStyle.roundedRect

        return view
    }()
    
    private let checkGuessButton = CustomButton(title: "Проверить", titleColor: .white)
    
    private var resultLabel: UILabel = {
        let view = UILabel()
        view.text = "Угадайте слово"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 0
        
        return view
    }()
    
    let button1: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Посмотреть пост 1", for: .normal)
        
        return view
    }()
    
    let button2: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Посмотреть пост 2", for: .normal)
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(resultLabel)
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        view.backgroundColor = .systemOrange
        
        view.addSubview(stackView)
        view.addSubview(checkGuessButton)
        
        setupConstraints()
        addTargetOnButton()
        
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        checkGuessButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            
            resultLabel.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor, constant: 70),
            resultLabel.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor, constant: -70),
            
            checkGuessButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 50),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -50)
        ])
    }
    
    private func addTargetOnButton() {
        button1.addTarget(self, action: #selector(onButtonPressed(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(onButtonPressed(_:)), for: .touchUpInside)
        checkGuessButton.tapAction = { [weak self] in
            self?.checkButtonPressed()
        }
    }
    
    @objc private func onButtonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.title = postTitle.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func checkButtonPressed() {
        let enterText = textField.text
        guard let enterText, !enterText.isEmpty else { return }
    
        let checkResult = feedModel.check(word: enterText)
        if checkResult {
            resultLabel.backgroundColor = .systemGreen
            resultLabel.text = "Угадали!"
        } else {
            resultLabel.backgroundColor = .systemRed
            resultLabel.text = "Не угадали..."
        }
    }
}
