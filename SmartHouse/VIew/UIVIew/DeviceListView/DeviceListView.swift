import UIKit

class DeviceListView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeviceListTableViewCell.self, forCellReuseIdentifier: "DLCell")
        return tableView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createConstrains()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createConstrains() {
        tableView.removeAllConstraints()
        backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
