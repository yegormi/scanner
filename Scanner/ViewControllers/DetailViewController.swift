import UIKit

class DetailViewController: UIViewController {
    
    private let device: Device
    
    private lazy var backgroundCard: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundCard")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var wifiImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = device.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var deviceInfoView: DeviceInfoView = {
        let infoView = DeviceInfoView(device: device)
        infoView.backgroundColor = .itemBackground
        infoView.set(cornerRadius: 8)
        return infoView
    }()
    
    init(device: Device) {
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Device Details"
        view.backgroundColor = .backgroundBlack
        setupUI()
    }
    
    private func setupUI() {
        view.setSubviewsForAutoLayout([
            backgroundCard,
            wifiImage,
            deviceInfoView,
        ])
        
        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            wifiImage.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            wifiImage.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 128),
            
            deviceInfoView.topAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -50),
            deviceInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deviceInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
