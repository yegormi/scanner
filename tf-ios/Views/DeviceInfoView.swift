import UIKit

class IntrinsicTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

struct DeviceInfoCellData {
    let property: String
    let info: String
}

class DeviceInfoView: UIView {
    
    private let device: Device
    private let cellData: [DeviceInfoCellData]
    
    private lazy var nameLabel: UILabel = {
        return makeLabel(
            textColor: .purplePrimary, 
            font: .roboto(.bold, size: 28),
            alignment: .center
        )
    }()
    
    private lazy var ipAddressLabel: UILabel = {
        return makeLabel(
            textColor: .white,
            font: .roboto(.regular, size: 15),
            alignment: .center
        )
    }()
    
    private lazy var infoTableView: UITableView = {
        let tableView = IntrinsicTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 48
        tableView.register(DeviceInfoCell.self, forCellReuseIdentifier: "InfoCell")
        return tableView
    }()
    
    init(device: Device) {
        self.device = device
        self.cellData = [
            DeviceInfoCellData(property: "Connection Type", info: device.connectionType.rawValue),
            DeviceInfoCellData(property: "MAC Address", info: device.macAddress.value),
            DeviceInfoCellData(property: "Hostname", info: device.hostname.value),
            DeviceInfoCellData(property: "State", info: device.state == .success ? "Success" : "Fail")
        ]
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setSubviewsForAutoLayout([
            nameLabel,
            ipAddressLabel,
            infoTableView,
        ])
        
        nameLabel.text = device.wifiName.value
        ipAddressLabel.text = device.ipAddress.value
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ipAddressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            ipAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ipAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            infoTableView.topAnchor.constraint(equalTo: ipAddressLabel.bottomAnchor, constant: 24),
            infoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension DeviceInfoView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! DeviceInfoCell
        let data = cellData[indexPath.row]
        cell.configure(withProperty: data.property, info: data.info)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

extension DeviceInfoView {
    private func makeLabel(textColor: UIColor, font: UIFont, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        return label
    }
}
