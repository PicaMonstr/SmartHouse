import Foundation
import UIKit

enum ProductType: String, Codable, CaseIterable {
    
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}

enum Mode: String, Codable {
    
    case on = "ON"
    case off = "OFF"
}

struct DeviceResponseModel: Codable {
    
    var devices: [Device] = []
}

struct Device: Codable {
    
    let id: Int
    let deviceName: String
    var intensity: Int?
    var mode: Mode?
    let productType: ProductType
    var position: Int?
    var temperature: Double?
}
