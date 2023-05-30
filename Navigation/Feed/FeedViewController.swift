import UIKit

class FeedViewController: UIViewController {
    
    let postTitle = "Мои лучшие рецепты"
    
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
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        view.backgroundColor = .systemOrange
        
        view.addSubview(stackView)
        
        setupConstraints()
        addTargetButton()
        
    }
    
    func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
        ])
    }
    
    func addTargetButton() {
        button1.addTarget(self, action: #selector(onButonPressed(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(onButonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func onButonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.title = postTitle
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
