import CoreData

extension NSManagedObject {

    static var identifier: String {
        String(describing: self)
    }
}
