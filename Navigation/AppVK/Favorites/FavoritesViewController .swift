import UIKit

final class FavoritesViewController: UIViewController {
    let viewModel: FavoritesViewModel
    var posts: [Post] = []
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
        postTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранные посты"
        navigationController?.navigationBar.prefersLargeTitles = true
        view = postTableView
        view.backgroundColor = AppVKСolor.forBackground
        bindViewModel()
        setupTable()
    }
    
    func bindViewModel() {
        viewModel.onSavedPostsDidChange = { [weak self] posts in
            self?.posts = posts
        }
    }
    
    func setupTable() {
        postTableView.tableHeaderView = UIView()
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
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.id, for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
