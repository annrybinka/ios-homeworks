import UIKit

class LogInViewController: UIViewController {
    
    private var loginViewModel: LoginViewModelProtocol
    
    init(loginViewModel: LoginViewModelProtocol) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    let logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var loginText: UITextField = {
        let view = UITextField()
        view.placeholder = "Email or phone"
        view.text = "test"
        view.backgroundColor = .systemGray6
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16)
        view.tintColor = UIColor(named: "AccentColor")
        view.autocapitalizationType = .none
        view.borderStyle = UITextField.BorderStyle.roundedRect
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.delegate = self
        
        return view
    }()
    
    private lazy var passwordText: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.text = "1234"
        view.isSecureTextEntry = true
        view.backgroundColor = .systemGray6
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16)
        view.tintColor = UIColor(named: "AccentColor")
        view.autocapitalizationType = .none
        view.borderStyle = UITextField.BorderStyle.roundedRect
        view.returnKeyType = UIReturnKeyType.done
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.delegate = self
        
        return view
    }()
    
    let delimiter: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.spacing = 0
        
        stackView.addArrangedSubview(loginText)
        stackView.addArrangedSubview(delimiter)
        stackView.addArrangedSubview(passwordText)
        
        return stackView
    }()
    
    private lazy var logInButton = CustomButton(title: "Log in", titleColor: .white) { [weak self] in self?.onButtonPressed() }
    
    private lazy var crackPasswordButton = CustomButton(title: "Crack the password", titleColor: .lightGray) { [weak self] in self?.crackPasswordPressed() }
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
        
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(stackView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(logInButton)
        contentView.addSubview(crackPasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        crackPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: passwordText.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordText.centerYAnchor),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            crackPasswordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            crackPasswordButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            crackPasswordButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            crackPasswordButton.heightAnchor.constraint(equalToConstant: 35),
            crackPasswordButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func onButtonPressed() {
        let login = loginText.text
        let password = passwordText.text
        
        loginViewModel.userAuthenticate(login: login, password: password)
    }
    
    private func crackPasswordPressed() {
        loginViewModel.crackPassword()
    }
    
    private func bindViewModel() {
        loginViewModel.onAlertMessageDidChange = { [weak self] message in
            self?.showAlert(message: message)
        }
        loginViewModel.onPasswordCracked = { [weak self] crackedPassword in
            self?.passwordText.text = crackedPassword
            self?.passwordText.isSecureTextEntry = false
        }
        loginViewModel.onPasswordCrackingStarted = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        loginViewModel.onPasswordCrackingFinished = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func showAlert(message: String?) {
        let loginAlertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let OkAction = UIAlertAction(title: "OK", style: .default) {_ in }
        loginAlertController.addAction(OkAction)
        present(loginAlertController, animated: true)
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyoard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyoard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func willShowKeyoard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyoard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
