import UIKit

protocol WiFiBoxDelegate: AnyObject {
    func getWiFiName() -> String
    func scanNetwork()
}

class WiFiBoxView: UIView {
    
    weak var delegate: WiFiBoxDelegate? {
        didSet {
            self.updateWiFiName()
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Wi-Fi"
        label.font = .roboto(.regular, size: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wifiNameLabel: UILabel = {
        let label = UILabel()
        label.text = delegate?.getWiFiName() ?? "WIFI_Name"
        label.font = .roboto(.bold, size: 28)
        label.textColor = .purplePrimary
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ready to Scan this network"
        label.font = .roboto(.regular, size: 17)
        label.textColor = .appGrey
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scanButton: UIButton = {
        let button = UIButton(type: .system)
        button.set(cornerRadius: 25)
        button.setBackgroundColor(.purplePrimary, for: .normal)
        button.setTitle("Scan current network", for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.titleLabel?.font = .roboto(.medium, size: 20)
        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .itemBackground
        self.layer.cornerRadius = 8
        
        self.setSubviewsForAutoLayout([
            titleLabel,
            wifiNameLabel,
            descriptionLabel,
            scanButton,
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            wifiNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            wifiNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wifiNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: wifiNameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            scanButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            scanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            scanButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
    
    @objc private func scanButtonTapped() {
        delegate?.scanNetwork()
    }
    
    func updateWiFiName() {
        wifiNameLabel.text = delegate?.getWiFiName() ?? "WIFI_Name"
    }
}
