import UIKit

class ProfileHeaderView: UIView {
    let fullNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = AppVKСolor.forText
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 3
        view.layer.borderColor = AppVKСolor.lightGray.cgColor
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var setStatusButton = CustomButton(title: "Show status", titleColor: .white) { [weak self] in print((self?.statusLabel.text)!) }
    
    let statusLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = AppVKСolor.lightGray
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func configure(user: User) {
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
        avatarImageView.image = user.avatar
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(fullNameLabel)
        addSubview(avatarImageView)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        
        let imageHeight = 100
        avatarImageView.layer.cornerRadius = CGFloat(imageHeight/2)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: CGFloat(imageHeight)),
            avatarImageView.widthAnchor.constraint(equalToConstant: CGFloat(imageHeight)),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34)
        ])
    }
}
