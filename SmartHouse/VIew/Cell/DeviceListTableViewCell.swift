import UIKit
import CoreData

struct DeviceListTableCellModel {
    
    var name: String
    var stateText: String
    var modeImage: UIImage?
}

class DeviceListTableViewCell: UITableViewCell {
    
    private lazy var nameLabel = UILabel()
    private lazy var stateLabel = UILabel()
    private lazy var deviceModeImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default , reuseIdentifier: "DLCell")
        
        self.backgroundColor = .black
        stateLabel.textColor = .white
        nameLabel.textColor = .white
        addSubview(nameLabel)
        addSubview(stateLabel)
        addSubview(deviceModeImage)
        createConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        createConstrains()
    }
    
    func config(model: DeviceListTableCellModel) {
        nameLabel.text = model.name
        stateLabel.text = model.stateText
        deviceModeImage.image = model.modeImage

    }
    
    private func createConstrains() {
        
        nameLabel.numberOfLines = 0
        nameLabel.font = nameLabel.font.withSize(20)
        
        nameLabel.removeAllConstraints()
        deviceModeImage.removeAllConstraints()
        stateLabel.removeAllConstraints()
        
        deviceModeImage.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deviceModeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            deviceModeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            deviceModeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            deviceModeImage.heightAnchor.constraint(equalToConstant: 50),
            deviceModeImage.widthAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: deviceModeImage.leadingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: stateLabel.topAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stateLabel.trailingAnchor.constraint(greaterThanOrEqualTo: deviceModeImage.leadingAnchor, constant: -10),
 
        ])
    }
}
