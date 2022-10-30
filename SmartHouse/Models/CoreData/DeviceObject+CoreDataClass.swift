//
//  DeviceObject+CoreDataClass.swift
//  TTSourceAngel
//
//  Created by Denys on 11.08.2022.
//
//

import Foundation
import CoreData

@objc(DeviceObject)
public class DeviceObject: NSManagedObject, Identifiable {
    
    @NSManaged public var deviceName: String
    @NSManaged public var id: Int64
    @NSManaged public var productType: String
    
    init(device: Device, description: NSEntityDescription, context: NSManagedObjectContext) {
        super.init(entity: description, insertInto: context)
        
        self.deviceName = device.deviceName
        self.id = Int64(device.id)
        self.productType = device.productType.rawValue
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func cellModel() -> DeviceListTableCellModel {
        fatalError("Must be overriden")
    }
    
    
}
