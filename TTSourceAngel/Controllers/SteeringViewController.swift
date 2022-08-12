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
}


