import UIKit

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

class ProfileViewController: UIViewController {

    private var dataSource = [
        Post(author: "Mary Asana", description: "Text about yoga, about yoga, about yoga, about yoga, about yoga, about yoga, about yoga, about yoga, about yoga", image: "yoga", likes: 15, views: 30),
        Post(author: "Chef Harry", description: "10 egg breakfast recipes", image: "food", likes: 21, views: 45),
        Post(author: "Nike dairy", description: "Just do it", image: "sport", likes: 13, views: 101),
        Post(author: "Buy a new Hyundai 2023 from an authorized dealer", description: "The best cars this year", image: "cars", likes: 99, views: 156)
    ]
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        setupUI()
        setupTable()
        
    }
    
    func setupTable() {
        tableView.setAndLayout(headerView: ProfileHeaderView())
        tableView.tableFooterView = UIView()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.id
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        
        view.addSubview(tableView)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = dataSource[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
