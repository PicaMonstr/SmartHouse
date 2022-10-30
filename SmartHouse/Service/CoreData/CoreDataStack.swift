import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    // MARK: - CoreDataStack
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(
            forResource: "TTSourceAngel",
            withExtension: "momd"
        ) else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "TTSourceAngel.sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Methods
    
    func fetchDevices() -> [DeviceObject] {
        
        let fetchRequest = NSFetchRequest<DeviceObject>(entityName: "DeviceObject")
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return []
    }
    
    func fetchDevices<T: DeviceObject>(ofType: T.Type) -> [T] {
        
        let fetchRequest = NSFetchRequest<T>(entityName: T.identifier)
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return []
    }
    
    func fetchDevice(with id: Int) -> DeviceObject? {
        
        let fetchRequest = NSFetchRequest<DeviceObject>(entityName: "DeviceObject")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            return try managedObjectContext.fetch(fetchRequest).first
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func clearData() {
        
        let fetchRequest = NSFetchRequest<DeviceObject>(entityName: "DeviceObject")
        
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            for obj in objects {
                managedObjectContext.delete(obj)
            }
        } catch let error {
            print(error)
        }
    }
}
