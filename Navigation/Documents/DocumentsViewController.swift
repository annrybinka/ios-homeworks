import UIKit

class DocumentsViewController: UIViewController {
    private var items: [DocumentsViewModel.Item]
    private var viewModel: DocumentsViewModelProtocol
    
    init(viewModel: DocumentsViewModelProtocol) {
        self.viewModel = viewModel
        self.items = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView = UITableView(frame: .null)
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "plus"),
                style: .done,
                target: self,
                action: #selector(rightButtonTapped(_:))
            )
        ]
        setupTable()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewReady()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.onItemsChanged = { [weak self] items in
            self?.items = items
            self?.tableView.reloadData()
        }
    }
    
    @objc private func rightButtonTapped(_ sender: UIButton) {
        viewModel.showImagePicker()
    }
}

extension DocumentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "DocumentsTableViewCell")
        cell.textLabel?.text = items[indexPath.row].title
        if items[indexPath.row].isDirectory {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onItemPressed(index: indexPath.row)
    }
}
