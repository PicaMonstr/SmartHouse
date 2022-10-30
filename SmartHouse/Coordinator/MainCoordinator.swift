import Foundation
import UIKit

enum Event {
    
    case cellSelected(device: DeviceObject)
    case closeDetailVC
}

class MainCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    func controllSteeringViewController(with type: Event) {
        
        switch type {
        case .cellSelected(let device):
            let vc = SteeringViewController()
            vc.viewModel.device = device
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        case .closeDetailVC:
            navigationController.popViewController(animated: true)
        }
    }
    
    func start() {
        
        let vc = DeviceListViewController()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
}
