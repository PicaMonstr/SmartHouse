import Foundation

protocol RequestProtocol {
    
    func request(complition: @escaping (DeviceResponseModel) -> Void)
}
