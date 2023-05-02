import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()
    
    let button: UIButton = {
        let view = UIButton()
        view.backgroundColor = .darkGray
        view.setTitle("New button", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitleColor(.green, for: .highlighted)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = .lightGray
        
        setupUI()
        
    }
    
    func setupUI() {
        
        view.addSubview(profileHeader)
        view.addSubview(button)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeader.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeader.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeader.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeader.heightAnchor.constraint(equalToConstant: 220),
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor),
            button.rightAnchor.constraint(equalTo: view.rightAnchor),
            button.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
