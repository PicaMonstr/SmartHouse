import Foundation
import CoreData

protocol DelegateDeviceViewControllerModel: AnyObject {
    
    func updateView(with sections: [DeviceSection])
}

class DeviceViewControllerModel: NSObject {
    
    private var request: RequestDeviceList!
    weak var delegate: DelegateDeviceViewControllerModel?
    private let fetchController: NSFetchedResultsController<DeviceObject>!
    
    private let defaults = UserDefaults.standard
    private var isGetDeviceList = false
    
    var sections: [DeviceSection] = [] {
        didSet {
            delegate?.updateView(with: sections)
        }
    }
    
    override init() {
        
        let flag = defaults.bool(forKey: "isGet")
        self.isGetDeviceList = flag
        self.request = RequestDeviceList()
        
        let fetchRequest = NSFetchRequest<DeviceObject>(entityName: "DeviceObject")
        fetchRequest.sortDescriptors = [.init(key: "id", ascending: true)]
        self.fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStack.shared.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        
        self.fetchController.delegate = self
        
        getDevicesList()
        
        do {
            try fetchController.performFetch()
            createSections(with: fetchController.fetchedObjects ?? [])
        } catch let error {
            print(error)
        }
    }
    
    func getDevicesList() {
        
        if !isGetDeviceList {
            defaults.set(true, forKey: "isGet")
            CoreDataStack.shared.clearData()
            self.request.request { response in
                let context = CoreDataStack.shared.managedObjectContext
                response.devices.forEach {
                    switch $0.productType {
                    case .heater: _ = HeaterObject(device: $0, context: context)
                    case .light: _ = LightObject(device: $0, context: context)
                    case .rollerShutter: _ = RollerShutterObject(device: $0, context: context)
                    }
                }
                CoreDataStack.shared.saveContext()
            }
        }
    }
    
    func createSections(with devices: [DeviceObject]) {
        var result: [DeviceSection] = []
        result.append(DeviceSection(
            type: .heater, devices: devices.filter({ $0.productType == ProductType.heater.rawValue }))
        )
        result.append(DeviceSection(
            type: .light, devices: devices.filter({ $0.productType == ProductType.light.rawValue }))
        )
        result.append(DeviceSection(
            type: .rollerShutter, devices: devices.filter({ $0.productType == ProductType.rollerShutter.rawValue }))
        )
        sections = result
    }
}

extension DeviceViewControllerModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        createSections(with: controller.fetchedObjects as? [DeviceObject] ?? [])
    }
}
