import UIKit

class FeedViewController: UIViewController {
    
    let postTitle = "Мои лучшие рецепты"
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Посмотреть пост", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        view.backgroundColor = .systemOrange
        
        view.addSubview(postButton)
        postButton.addTarget(self, action: #selector(onButonPressed(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    @objc func onButonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.title = postTitle
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
