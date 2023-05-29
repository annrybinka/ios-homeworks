import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let id = "PostTableViewCell"
    
    let authorLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let postImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let postTextLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.textColor = .systemGray
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let likesLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .light)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let viewsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .light)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func configure(with post: Post) {
        authorLabel.text = post.author
        postTextLabel.text = post.description
        postImageView.image = UIImage(named: post.image)
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        accessoryType = .none
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubviews() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(postTextLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            postTextLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: postTextLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: postTextLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }

}
