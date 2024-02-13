import UIKit

final class SettingsViewController: UIViewController {
    private var viewModel: SettingsViewModelProtocol
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView = UITableView(frame: .null)
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch(frame: .infinite)
        view.addTarget(self, action: #selector(sortTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchView.isOn = viewModel.isSortStateAlphabetical()
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func sortTapped(_ sender: UISwitch) {
        viewModel.onSortPressed(isAlphabetical: switchView.isOn)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "SettingsTableViewCell")
        if indexPath.row == 0 {
            cell.textLabel?.text = "Сортировка по алфавиту"
            cell.accessoryView = switchView
        }
        if indexPath.row == 1 {
            cell.textLabel?.text = "Поменять пароль"
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            viewModel.onChangePasswordPressed()
        }
    }
}
