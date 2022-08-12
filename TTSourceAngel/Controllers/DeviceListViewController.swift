import UIKit

class DeviceListViewController: UIViewController, Coordinating {
    
    var coordinator: CoordinatorProtocol?
    private var deviceView: DeviceListView!
    var viewModel: DeviceViewControllerModel!
    private var tableViewDataSource: DeviceTableViewDataSource!
    
    override func loadView() {
        super.loadView()
        
        deviceView = DeviceListView()
        view = deviceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DeviceViewControllerModel()
        tableViewDataSource = DeviceTableViewDataSource(onItemSelection: { [weak self] device in
            self?.coordinator?.controllSteeringViewController(
                with: .cellSelected(device: device)
            )
        })
        title = NSLocalizedString("title_Devices_List", comment: "title")
        viewModel.delegate = self
        deviceView.tableView.delegate = tableViewDataSource
        deviceView.tableView.dataSource = tableViewDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        updateView(with: viewModel.sections)
    }
}

extension DeviceListViewController: DelegateDeviceViewControllerModel {
    
    func updateView(with sections: [DeviceSection]) {
        DispatchQueue.main.async {
            self.tableViewDataSource.sections = sections
            self.deviceView.tableView.reloadData()
        }
    }
}
