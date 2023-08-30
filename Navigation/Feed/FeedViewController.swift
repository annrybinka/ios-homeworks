import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let postTitle = PostTitle(title: "Мои лучшие рецепты")
    
    private var feedViewModel: FeedViewModelProtocol
    
    init(feedViewModel: FeedViewModelProtocol) {
        self.feedViewModel = feedViewModel
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
    
    private lazy var checkGuessButton = CustomButton(title: "Проверить", titleColor: .white) { [weak self] in
        self?.checkButtonPressed() }
    
    private lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Посмотреть пост", for: .normal)
        view.addTarget(self, action: #selector(onButtonPressed(_:)), for: .touchUpInside)
        
        return view
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(textField)
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        view.addSubview(checkGuessButton)
        
        setupConstraints()
        bindViewModel()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        checkGuessButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            
            checkGuessButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 50),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -50)
        ])
    }
    
    @objc private func onButtonPressed(_ sender: UIButton) {
        feedViewModel.onFeedPressed()
    }
    
    private func bindViewModel() {
        feedViewModel.onAlertStateDidChange = { [weak self] alertState in
            self?.showAlert(message: alertState.text, title: alertState.title)
        }
    }
    
    private func checkButtonPressed() {
        feedViewModel.onWordChanged(word: textField.text)
    }
    
    private func showAlert(message: String?, title: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let OkAction = UIAlertAction(title: "OK", style: .default) {_ in }
        alertController.addAction(OkAction)
        present(alertController, animated: true)
    }
}
