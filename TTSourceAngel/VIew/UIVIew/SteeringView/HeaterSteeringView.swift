//
//  HeaterSteeringView.swift
//  TTSourceAngel
//
//  Created by Denys on 11.08.2022.
//

import UIKit

class HeaterSteeringView: UIView {
    
    var device: HeaterObject?
    weak var delegate: SaveDeviceDelegate?
    
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
        stepper.minimumValue = 7
        stepper.maximumValue = 28
        stepper.stepValue = 0.5
        
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
    
    @objc func switchChangeHeater() {
        (switchMode.isOn) ? (device?.mode = Mode.on.rawValue) : (device?.mode = Mode.off.rawValue)
        (switchMode.isOn) ? (imageView.image = UIImage(named: "DeviceHeaterOnIcon")) : (imageView.image = UIImage(named: "DeviceHeaterOffIcon"))
        delegate?.saveDevice(item: device!)
    }
    
    @objc func stepperTouch() {
        device?.temperature = NSDecimalNumber(value: stepper.value)
        valueLabel.text = String(format: "%.1f", stepper.value) + "˚C"
        delegate?.saveDevice(item: device!)
    }
    
    func config(item: HeaterObject) {
        switchMode.addTarget(self, action: #selector(switchChangeHeater), for: .valueChanged)
        stepper.addTarget(self, action: #selector(stepperTouch), for: .valueChanged)
        stepper.value = Double(item.temperature!)
        valueLabel.text = String(format: "%.1f", stepper.value) + "˚C"
        switch Mode(rawValue: item.mode ?? "") {
        case .on:
            switchMode.isOn = true
            imageView.image = UIImage(named: "DeviceHeaterOnIcon")
        case .off:
            switchMode.isOn = false
            imageView.image = UIImage(named: "DeviceHeaterOffIcon")
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
            switchMode.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            switchMode.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
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
            imageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }}
