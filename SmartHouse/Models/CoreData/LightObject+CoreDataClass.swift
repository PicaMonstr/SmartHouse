//
//  LightObject+CoreDataClass.swift
//  TTSourceAngel
//
//  Created by Denys on 11.08.2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(LightObject)
public class LightObject: DeviceObject {

    @NSManaged public var intensity: NSDecimalNumber
    @NSManaged public var mode: String
    
    init(device: Device, context: NSManagedObjectContext) {
        super.init(
            device: device,
            description: .entity(forEntityName: Self.identifier, in: context)!,
            context: context
        )
        
        self.intensity = NSDecimalNumber(value: device.intensity ?? 0)
        self.mode = (device.mode ?? .off).rawValue
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    override func cellModel() -> DeviceListTableCellModel {
        return .init(
            name: deviceName,
            stateText: NSLocalizedString("value_Label_Light", comment: "intensity")
            + String(intensity.intValue) + "%",
            modeImage: Mode(rawValue: mode) == .on
            ? UIImage(named: "DeviceLightOnIcon")
            : UIImage(named: "DeviceLightOffIcon")
        )
    }
}
