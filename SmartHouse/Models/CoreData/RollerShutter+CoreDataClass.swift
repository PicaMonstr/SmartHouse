//
//  RollerShutter+CoreDataClass.swift
//  TTSourceAngel
//
//  Created by Denys on 11.08.2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(RollerShutterObject)
public class RollerShutterObject: DeviceObject {

    @NSManaged public var position: NSDecimalNumber
    
    init(device: Device, context: NSManagedObjectContext) {
        super.init(
            device: device,
            description: .entity(forEntityName: Self.identifier, in: context)!,
            context: context
        )
        
        self.position = NSDecimalNumber(value: device.position ?? 0)
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    override func cellModel() -> DeviceListTableCellModel {
        return .init(
            name: deviceName,
            stateText: NSLocalizedString("value_Label_RollerShutter", comment: "position")
            + String(position.intValue) + "%",
            modeImage: UIImage(named: "DeviceRollerShutterIcon")
        )
    }
}
