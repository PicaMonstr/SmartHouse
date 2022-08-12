import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func controllSteeringViewController(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: CoordinatorProtocol? { get set }
}
