import UIKit

class SteeringViewController: UIViewController, Coordinating {
    
    var coordinator: CoordinatorProtocol?
    var viewModel: SteeringViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        viewModel = SteeringViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = viewModel.options()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let device = viewModel.device {
            title = device.deviceName
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if view === LightSteeringView.self {
            viewModel.closeSteeringViewController(item: (view as! LightSteeringView).device!)
        } else if view === HeaterSteeringView.self {
            viewModel.closeSteeringViewController(item: (view as! HeaterSteeringView).device!)
        } else if view === RollerShutterSteeringView.self {
            viewModel.closeSteeringViewController(item: (view as! RollerShutterSteeringView).device!)
        }
        coordinator?.controllSteeringViewController(with: .closeDetailVC)
        CoreDataStack.shared.saveContext()
    }
}


