import UIKit

class RollerShutterSteeringView: UIView {
    
    var device: RollerShutterObject?
    weak var delegate: SaveDeviceDelegate?
    
    lazy var imageView = UIImageView()
    lazy var slider: UISlider = {
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = UIColor(named: "LightSteelBlue")
        return slider
    }()
    lazy var valueLabel: UILabel = {
        
        let valueLabel = UILabel()
        valueLabel.textColor = .white
        return valueLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createConstrains()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(slider)
        addSubview(valueLabel)
        
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func sliderChange() {
        device?.position = NSDecimalNumber(value: slider.value)
        valueLabel.text = String(format: "%.0f", slider.value)
        delegate?.saveDevice(item: device!)
    }
    
    func config(item: RollerShutterObject) {
        slider.addTarget(self, action: #selector(sliderChange), for: .valueChanged)
        slider.value = Float(item.position)
        valueLabel.text = String(format: "%.0f", slider.value)
        imageView.image = UIImage(named: "DeviceRollerShutterIcon")
        
    }
    
    func createConstrains() {
        
        slider.removeAllConstraints()
        valueLabel.removeAllConstraints()
        imageView.removeAllConstraints()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: self.frame.width - 20)
        ])
        NSLayoutConstraint.activate([
            valueLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
