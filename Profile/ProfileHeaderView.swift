import UIKit

class ProfileHeaderView: UIView {
    
    let headerText: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.text = "Hipster Cat"
        view.numberOfLines = 0
        
        return view
    }()
    
    let headerImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let headerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .blue
        view.setTitle("Show status", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitleColor(.green, for: .highlighted)
        return view
    }()
    
    let headerStatus: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.text = "Waiting for status..."
        view.numberOfLines = 0
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(headerText)
        addSubview(headerImage)
        addSubview(headerButton)
        addSubview(headerStatus)
        
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        let imageHeight = 100
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            headerImage.heightAnchor.constraint(equalToConstant: CGFloat(imageHeight)),
            headerImage.widthAnchor.constraint(equalToConstant: CGFloat(imageHeight))
        ])
        
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            headerText.leftAnchor.constraint(equalTo: headerImage.rightAnchor, constant: 16)
        ])

        headerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerButton.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 16),
            headerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            headerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            headerButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        headerStatus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerStatus.leftAnchor.constraint(equalTo: headerImage.rightAnchor, constant: 16),
            headerStatus.bottomAnchor.constraint(equalTo: headerButton.topAnchor, constant: -34)
        ])

        headerImage.layer.borderWidth = 3
        headerImage.layer.borderColor = UIColor.white.cgColor
        headerImage.layer.cornerRadius = CGFloat(imageHeight/2)
        //способ из лекции (не работает)
//        headerImage.layer.contents = UIImage(named: "cat")?.cgImage
//        headerImage.layer.contentsGravity = .resizeAspect
//        headerImage.layer.masksToBounds = true
        //свой вариант
        headerImage.image = UIImage(named: "cat")
        headerImage.clipsToBounds = true
        headerImage.contentMode = .scaleAspectFill

        headerButton.layer.cornerRadius = 16
        headerButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        headerButton.layer.shadowRadius = 4
        headerButton.layer.shadowColor = UIColor.black.cgColor
        headerButton.layer.shadowOpacity = 0.7
        headerButton.clipsToBounds = false
        
        headerButton.addTarget(
            self,
            action: #selector(onButonPressed(_:)),
            for: .touchUpInside
        )

    }
    
    @objc func onButonPressed(_ sender: UIBarButtonItem) {
        print((headerStatus.text)!)
    }

}
