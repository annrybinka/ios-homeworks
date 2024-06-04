import UIKit

class PhotosTableViewCell: UITableViewCell {
    static let id = "PhotosTableViewCell"

    private lazy var photosLabel: UILabel = {
        let view = UILabel()
        view.text = "Photos"
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.textColor = AppVKСolor.forText
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.right")
        view.tintColor = AppVKСolor.forText
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(assetNames: [String]) {
        photoStackView.arrangedSubviews.forEach {$0.removeFromSuperview()}
        for name in assetNames {
            let view = UIImageView()
            view.image = UIImage(named: name)
            view.contentMode = .scaleAspectFill
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            photoStackView.addArrangedSubview(view)
        }
    }
    
    func addSubviews() {
        contentView.backgroundColor = AppVKСolor.forBackground
        contentView.addSubview(photosLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(photoStackView)
    }
    
    func setupConstraints() {
        let viewSpacing: CGFloat = 8.0
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: viewSpacing),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewSpacing),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewSpacing),
            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            photoStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: viewSpacing),
            photoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -viewSpacing),
            photoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewSpacing),
            photoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewSpacing)
        ])
    }
}
