import Foundation
import UIKit
import CoreData

struct DeviceSection {
    
    var type: ProductType
    var devices: [DeviceObject]
}

class DeviceTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var sections: [DeviceSection] = []
    
    var onItemSelection: ((DeviceObject) -> Void)?
    
    init(onItemSelection: ((DeviceObject) -> Void)?) {
        self.onItemSelection = onItemSelection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DLCell", for: indexPath
        ) as? DeviceListTableViewCell else { return UITableViewCell() }
        
        cell.config(model: sections[indexPath.section].devices[indexPath.row].cellModel())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .lightGray
        label.text = sections[section].type.rawValue
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onItemSelection?(sections[indexPath.section].devices[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

