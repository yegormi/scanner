import UIKit
import Lottie

class ScanViewController: UIViewController {
    private var state: RadarState = .running
    private var timer: Timer?
    private var counter: Int = 0
    
    private lazy var scanningLabel: UILabel = {
        let label = UILabel()
        label.font = .roboto(.regular, size: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Scanning Your Wi-Fi"
        return label
    }()
    
    private lazy var wifiName: UILabel = {
        let label = UILabel()
        label.font = .roboto(.bold, size: 28)
        label.textColor = .purplePrimary
        label.textAlignment = .center
        label.text = "TLind_246_lp"
        return label
    }()

    private lazy var animation: LottieAnimationView = {
        let animation = LottieAnimationView()
        let url = Bundle.main.url(forResource: "radar", withExtension: "lottie")!
        DotLottieFile.loadedFrom(url: url) { result in
            switch result {
            case .success(let file):
                animation.loadAnimation(from: file)
                animation.loopMode = .loop
                animation.play()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return animation
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .roboto(.medium, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "0%"
        return label
    }()
    
    private lazy var devicesFound: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        view.distribution = .equalCentering
        
        let number = UILabel()
        number.font = .roboto(.bold, size: 28)
        number.textColor = .purplePrimary
        number.textAlignment = .center
        number.text = "23"
        view.addArrangedSubview(number)
        
        let label = UILabel()
        label.font = .roboto(.medium, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Devices Found..."
        view.addArrangedSubview(label)
        
        return view
    }()
    
    private lazy var toggleButton: RoundCornerButton = {
        let button = RoundCornerButton(type: .system)
        button.setBackgroundColor(.purplePrimary, for: .normal)
        button.setTitle(state.title, for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.titleLabel?.font = .roboto(.medium, size: 20)
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlack
        self.title = ""
        setupUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        counter = 0
    }
    
    @objc private func updateCounter() {
        counter += 1
        updatePercentage(with: counter)
        if counter == 100 {
            resetTimer()
            toggleButtonTapped()
            self.push(ResultViewController())
        }
    }
    
    private func updatePercentage(with counter: Int) {
        percentageLabel.text = "\(counter)%"
    }
    
    private func setupUI() {
        view.setSubviewsForAutoLayout([
            scanningLabel,
            wifiName,
            animation,
            percentageLabel,
            devicesFound,
            toggleButton,
        ])
        
        NSLayoutConstraint.activate([
            scanningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            scanningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scanningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            wifiName.topAnchor.constraint(equalTo: scanningLabel.bottomAnchor),
            wifiName.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wifiName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            animation.topAnchor.constraint(equalTo: wifiName.bottomAnchor, constant: 71),
            animation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            animation.heightAnchor.constraint(equalToConstant: 350),
            
            percentageLabel.centerXAnchor.constraint(equalTo: animation.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: animation.centerYAnchor),
            
            devicesFound.topAnchor.constraint(equalTo: animation.bottomAnchor, constant: 32),
            devicesFound.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            toggleButton.topAnchor.constraint(equalTo: devicesFound.bottomAnchor, constant: 62),
            toggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func toggleButtonTapped() {
        switch state {
        case .running:
            animation.stop()
            resetTimer()
        case .stopped:
            animation.play()
            startTimer()
        }
        updatePercentage(with: counter)
        state.toggle()
        toggleButton.setTitle(state.title, for: .normal)
    }
}

private enum RadarState {
    case running
    case stopped
    
    var title: String {
        switch self {
        case .running:
            "Stop"
        case .stopped:
            "Run"
        }
    }
    
    mutating func toggle() {
        self = (self == .running) ? .stopped : .running
    }
}
