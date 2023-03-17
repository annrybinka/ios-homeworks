import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: .plain, target: self, action: #selector(moreTapped))
    
    }
    
    @objc func moreTapped(_ sender: UIBarButtonItem) {
        let infoViewController = InfoViewController()
    
        let nc = UINavigationController(rootViewController: infoViewController)
        nc.modalTransitionStyle = .coverVertical
        nc.modalPresentationStyle = .pageSheet
        
        present(nc, animated: true)
        
    }
    
}
