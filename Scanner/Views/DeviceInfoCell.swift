import UIKit

class DeviceInfoCell: UITableViewCell {
    
    private let propertyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .roboto(.regular, size: 17)
        label.textAlignment = .left
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGrey
        label.font = .roboto(.regular, size: 17)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.setSubviewsForAutoLayout([
            propertyLabel,
            infoLabel
        ])
        
        NSLayoutConstraint.activate([
            propertyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            propertyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(withProperty property: String, info: String) {
        propertyLabel.text = property
        infoLabel.text = info
    }
}
