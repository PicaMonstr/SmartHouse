import Foundation
import UIKit

class RequestDeviceList: RequestProtocol {
    
    var dataTask: URLSessionDataTask?
    
    func request(complition: @escaping (DeviceResponseModel) -> Void) {
        
        guard let url = URL(string: "http://storage42.com/modulotest/data.json") else { return }
        let sesion = URLSession.shared
        dataTask = sesion.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            do {
                let model = try JSONDecoder().decode(DeviceResponseModel.self, from: data)
                complition(model)
            } catch {
                print("error")
            }
        }
        dataTask?.resume()
    }
}
