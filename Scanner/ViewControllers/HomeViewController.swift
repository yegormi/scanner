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
    
    private lazy var backgroundCard: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundCard")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var wifiImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wifi")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var wifiBoxView: WiFiBoxView = {
        let wifiBox = WiFiBoxView()
        wifiBox.set(cornerRadius: 8)
        return wifiBox
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
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
            backgroundCard,
            wifiImage,
            wifiBoxView,
            scrollView,
            navigationView,
        ])
        
        scrollView.addSubview(navigationView)
        
        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundCard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            wifiImage.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            wifiImage.centerYAnchor.constraint(equalTo: backgroundCard.centerYAnchor),
            wifiImage.heightAnchor.constraint(equalTo: backgroundCard.heightAnchor, multiplier: 0.5),
            
            wifiBoxView.topAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -50),
            wifiBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wifiBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: wifiBoxView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            navigationView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            navigationView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            navigationView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
