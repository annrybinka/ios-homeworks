import SnapKit
import UIKit

class ProfileHeaderView: UIView {
    
    let fullNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.text = "Hipster Cat"
        view.numberOfLines = 0

        return view
    }()
    
    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.image = UIImage(named: "cat")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
       
        return view
    }()
    
    let setStatusButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .blue
        view.setTitle("Show status", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitleColor(.green, for: .highlighted)
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.clipsToBounds = false
       
        return view
    }()
    
    let statusLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.text = "Waiting for status..."
        view.numberOfLines = 0
       
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        addTargetButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(fullNameLabel)
        addSubview(avatarImageView)
        addSubview(setStatusButton)
        addSubview(statusLabel)
    }
    
    func setupConstraints() {
        let imageHeight = 100
        avatarImageView.layer.cornerRadius = CGFloat(imageHeight/2)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(imageHeight)
            make.width.equalTo(imageHeight)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.bottom.equalTo(setStatusButton.snp.top).offset(-34)
        }
    }
    
    func addTargetButton() {
        setStatusButton.addTarget(
            self,
            action: #selector(onButonPressed(_:)),
            for: .touchUpInside
        )
    }
    
    @objc func onButonPressed(_ sender: UIButton) {
        print((statusLabel.text)!)
    }

}
