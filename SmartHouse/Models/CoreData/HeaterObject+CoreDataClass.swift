//
//  HeaterObject+CoreDataClass.swift
//  TTSourceAngel
//
//  Created by Denys on 11.08.2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(HeaterObject)
public class HeaterObject: DeviceObject {

    @NSManaged public var temperature: NSDecimalNumber?
    @NSManaged public var mode: String?
    
    init(device: Device, context: NSManagedObjectContext) {
        super.init(
            device: device,
            description: .entity(forEntityName: Self.identifier, in: context)!,
            context: context
        )
        
        self.temperature = NSDecimalNumber(value: device.temperature ?? 0)
        self.mode = device.mode?.rawValue
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    override func cellModel() -> DeviceListTableCellModel {
        return .init(
            name: deviceName,
            stateText: NSLocalizedString("value_Label_Heater", comment: "temp")
            + String(temperature!.doubleValue)
            + " C˚",
            modeImage: Mode(rawValue: mode ?? "") == .on
            ? UIImage(named: "DeviceHeaterOnIcon")
            : UIImage(named: "DeviceHeaterOffIcon")
        )
    }
}
