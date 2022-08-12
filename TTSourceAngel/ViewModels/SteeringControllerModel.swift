import Foundation
import UIKit

protocol SaveDeviceDelegate: AnyObject {
    func saveDevice<T: DeviceObject>(item: T)
}

class SteeringViewModel: SaveDeviceDelegate {
    
    var device: DeviceObject?
    
    func saveDevice<T>(item: T) where T : DeviceObject {
        self.device = item
        CoreDataStack.shared.saveContext()
    }
//    func closeSteeringView<T: UIView>(item: T) {
//        if item === LightSteeringView.self {
//            closeSteeringViewController(item: (item as! LightSteeringView).device!)
//        } else if item === HeaterSteeringView.self {
//            closeSteeringViewController(item: (item as! HeaterSteeringView).device!)
//        } else if item === RollerShutterSteeringView.self {
//            closeSteeringViewController(item: (item as! RollerShutterSteeringView).device!)
//        }
//    }
//    func closeSteeringViewController<T: DeviceObject>(item: T) {
//        self.device = item
//        CoreDataStack.shared.saveContext()
//    }

    func options() -> UIView {
        guard let device = device else {
            return UIView()
        }

        switch device.productType {
        case ProductType.heater.rawValue:
            let array: [HeaterObject] = CoreDataStack.shared.fetchDevices(ofType: HeaterObject.self)
            let heaterView = HeaterSteeringView()
            for id in array {
                if device.id == id.id {
                    heaterView.config(item: id)
                    heaterView.device = id
                }
            }
            return heaterView
        case ProductType.light.rawValue:
            let array: [LightObject] = CoreDataStack.shared.fetchDevices(ofType: LightObject.self)
            let lightView = LightSteeringView()
            for id in array {
                if device.id == id.id {
                    lightView.config(item: id)
                    lightView.device = id
                }
            }
            return lightView
        case ProductType.rollerShutter.rawValue:
            let array: [RollerShutterObject] = CoreDataStack.shared.fetchDevices(ofType: RollerShutterObject.self)
            let rollerShutterView = RollerShutterSteeringView()
            for id in array {
                if device.id == id.id {
                    rollerShutterView.config(item: id)
                    rollerShutterView.device = id
                }
            }
            return rollerShutterView
        default: print("error")
            return UIView()
        }
    }
}


