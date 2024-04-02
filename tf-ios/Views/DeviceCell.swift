import UIKit

class DeviceCell: UITableViewCell {
    static let reuseID = "DeviceCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let wifiNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .roboto(.medium, size: 17)
        return label
    }()
    
    private let ipAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGrey
        label.font = .roboto(.medium, size: 13)
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .right
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .itemBackground
        
        contentView.setSubviewsForAutoLayout([
            iconImageView,
            arrowImageView,
            wifiNameLabel,
            ipAddressLabel
        ])
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            wifiNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            wifiNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            wifiNameLabel.bottomAnchor.constraint(equalTo: ipAddressLabel.topAnchor),
            
            ipAddressLabel.topAnchor.constraint(equalTo: wifiNameLabel.bottomAnchor),
            ipAddressLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            ipAddressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset properties here if needed
    }
    
    func configure(with device: Device) {
        wifiNameLabel.text = device.wifiName.value
        ipAddressLabel.text = device.ipAddress.value
        iconImageView.image = device.icon
    }
}
