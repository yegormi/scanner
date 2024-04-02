import UIKit

class HomeViewController: UIViewController {
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "settings")
        button.tintColor = .white
        button.style = .plain
        button.target = self
        button.action = #selector(settingsButtonTapped)
        return button
    }()
    
    private lazy var wifiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wifi")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var wifiBoxView: WiFiBoxView = {
        let wifiBox = WiFiBoxView()
        wifiBox.set(cornerRadius: 8)
        return wifiBox
    }()
    
    private var navigationView: NavigationCardView = {
        let view = NavigationCardView()
        view.cards = [
            NavigationCard(icon: UIImage(named: "infraredDetection")!, title: "Infrared Detection"),
            NavigationCard(icon: UIImage(named: "bluetoothDetection")!, title: "Bluetooth Detection"),
            NavigationCard(icon: UIImage(named: "magneticDetection")!, title: "Magnetic Detection"),
            NavigationCard(icon: UIImage(named: "antispyTips")!, title: "Antispy Tips")
        ]
        return view
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = settingsButton
        view.backgroundColor = .backgroundBlack
        self.title = ""
        
        wifiBoxView.delegate = self
        navigationView.delegate = self
        
        setupUI()
    }
    
    private func setupUI() {
        view.setSubviewsForAutoLayout([
            wifiImageView,
            wifiBoxView,
            navigationView
        ])
        
        NSLayoutConstraint.activate([
            wifiImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            wifiImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wifiImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            wifiBoxView.topAnchor.constraint(equalTo: wifiImageView.bottomAnchor, constant: -50),
            wifiBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wifiBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            navigationView.topAnchor.constraint(equalTo: wifiBoxView.bottomAnchor, constant: 16),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
    }
    
    @objc private func settingsButtonTapped() {
        print("Settings")
    }
}

extension HomeViewController: WiFiBoxDelegate {
    func getWiFiName() -> String {
        return "Mock Wi-Fi"
    }
    
    func scanNetwork() {
        self.push(ScanViewController())
    }
}

extension HomeViewController: NavigationCardDelegate {
    func didSelectCard(at index: Int) {
        switch index {
        case 0:
            print("First screen")
            break
        case 1:
            print("Second screen")
            break
        case 2:
            print("Third screen")
            self.push(MagneticViewController())
            break
        case 3:
            print("Fourth screen")
            break
        default:
            break
        }
    }
}
