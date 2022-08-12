import UIKit

class LightSteeringView: UIView {
    
    var device: LightObject?
    
    lazy var imageView = UIImageView()
    lazy var switchMode: UISwitch = {
        
        let switchMode = UISwitch()
        switchMode.onTintColor = UIColor(named: "LightSteelBlue")
        return switchMode
    }()
    lazy var stepper: UIStepper = {
        
        let stepper = UIStepper()
        stepper.backgroundColor = UIColor(named: "LightSteelBlue")
        stepper.layer.masksToBounds = true
        stepper.layer.cornerRadius = 15
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.stepValue = 1
        return stepper
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
        addSubview(switchMode)
        addSubview(imageView)
        addSubview(valueLabel)
        addSubview(stepper)
        
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func stepperTouch() {
        device?.intensity = NSDecimalNumber(value: stepper.value)
        valueLabel.text = String(format: "%.0f", stepper.value) + "%"
    }
    
    @objc func switchChangelight() {
        (switchMode.isOn) ? (device?.mode = Mode.on.rawValue) : (device?.mode = Mode.off.rawValue)
        (switchMode.isOn) ? (imageView.image = UIImage(named: "DeviceLightOnIcon")) : (imageView.image = UIImage(named: "DeviceLightOffIcon"))
    }
    
    func config(item: LightObject) {
        switchMode.addTarget(self, action: #selector(switchChangelight), for: .valueChanged)
        stepper.addTarget(self, action: #selector(stepperTouch), for: .valueChanged)
        
        stepper.value = Double(item.intensity)
        valueLabel.text = String(format: "%.0f", stepper.value) + "%"
        switch Mode(rawValue: item.mode) {
        case .on:
            switchMode.isOn = true
            imageView.image = UIImage(named: "DeviceLightOnIcon")
        case .off:
            switchMode.isOn = false
            imageView.image = UIImage(named: "DeviceLightOffIcon")
        default: print("error")
        }
    }
    
    func createConstrains() {
        switchMode.removeAllConstraints()
        stepper.removeAllConstraints()
        valueLabel.removeAllConstraints()
        imageView.removeAllConstraints()
        
        switchMode.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchMode.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            switchMode.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            stepper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stepper.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            valueLabel.bottomAnchor.constraint(equalTo: stepper.topAnchor, constant: -10),
            valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
