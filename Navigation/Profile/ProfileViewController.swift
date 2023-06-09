import UIKit

class ProfileViewController: UIViewController {
    
    let assetNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .grouped)
        #if DEBUG
        tableView.backgroundColor = .lightGray
        #else
        tableView.backgroundColor = UIColor(named: "AccentColor")
        #endif
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        postTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            postTableView.deselectRow(
                at: indexPath,
                animated: animated
            )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        view.backgroundColor = .lightGray
        #else
        view.backgroundColor = UIColor(named: "AccentColor")
        #endif
     
        setupUI()
        setupTable()
        
    }
    
    func setupTable() {
        let headerView = ProfileHeaderView()
        headerView.configure(user: user)
        headerView.bounds.size.height = 200
        postTableView.tableHeaderView = headerView
        postTableView.tableFooterView = UIView()
        
        postTableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.id
        )
        
        postTableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: PhotosTableViewCell.id
        )
        
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    func setupUI() {
        
        view.addSubview(postTableView)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            postTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.id, for: indexPath
            ) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(assetNames: Array(assetNames.prefix(4)))
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.id, for: indexPath
            ) as? PostTableViewCell else {
                return UITableViewCell()
            }
            let post = dataSource[indexPath.row]
            cell.configure(with: post)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            photosViewController.photosNames = assetNames
            photosViewController.title = "Photo Gallery"
            self.navigationController?.pushViewController(photosViewController, animated: true)
            navigationController?.navigationBar.isHidden = false
        }
    }
}
