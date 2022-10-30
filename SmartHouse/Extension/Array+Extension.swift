extension Array where Element == DeviceObject {

    func asSections() -> [DeviceSection] {
        var result: [DeviceSection] = []
        
        for type in ProductType.allCases {

            if !self.contains(where: { ProductType(rawValue: $0.productType) == type }) {
                continue
            }

            result.append(
                DeviceSection(
                    type: type,
                    devices: self.filter({ ProductType(rawValue: $0.productType) == type })
                )
            )
        }

        return result
    }
}
