import UIKit

class MagneticViewController: UIViewController {
    
    private var currentValue: CGFloat = 0
    private let totalValue: CGFloat = 100
    private let animationDuration: TimeInterval = 2.0
    private var state: State = .stopped {
        didSet {
            updateLabels()
        }
    }
    
    private lazy var magneticImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "magnetic")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var progressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "magneticProgress")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "magneticArrow")
        imageView.layer.anchorPoint = CGPoint(x: 0.6, y: 0.5)
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var magneticValue: UILabel = {
        let label = UILabel()
        label.font = .roboto(.medium, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Search checking"
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.set(cornerRadius: 25)
        button.setBackgroundColor(.purplePrimary, for: .normal)
        button.setTitle("Search", for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.titleLabel?.font = .roboto(.medium, size: 20)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Magnetic Detection"
        view.backgroundColor = .backgroundBlack
        setupUI()
        
        setGaugeValue(value: 0)
    }
    
    private func setupUI() {
        view.setSubviewsForAutoLayout([
            magneticImageView,
            progressImage,
            arrowView,
            magneticValue,
            searchButton,
        ])
        
        NSLayoutConstraint.activate([
            magneticImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            magneticImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            magneticImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            progressImage.topAnchor.constraint(equalTo: magneticImageView.bottomAnchor, constant: 62),
            progressImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            arrowView.topAnchor.constraint(equalTo: progressImage.topAnchor, constant: 154),
            arrowView.leadingAnchor.constraint(equalTo: progressImage.leadingAnchor),
            arrowView.trailingAnchor.constraint(equalTo: progressImage.trailingAnchor),
            
            magneticValue.topAnchor.constraint(equalTo: progressImage.bottomAnchor, constant: 47),
            magneticValue.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            magneticValue.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchButton.topAnchor.constraint(equalTo: magneticValue.bottomAnchor, constant: 87),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setGaugeValue(value: CGFloat) {
        let rotationAngle = value / totalValue * 180
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle.degreesToRadians)
        arrowView.transform = rotationTransform
    }
    
    @objc private func searchButtonTapped() {
        switch self.state {
        case .stopped:
            self.currentValue = 50
        case .searching:
            self.currentValue = 0
        }
        animateGauge(with: self.currentValue)
        state.toggle()
    }
    
    private func animateGauge(with newValue: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.setGaugeValue(value: newValue)
        }
    }
    
    private func updateLabels() {
        magneticValue.text = "\(Int(self.currentValue)) µT"
        searchButton.setTitle(self.state.title, for: .normal)
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { self * .pi / 180 }
}

private enum State {
    case searching
    case stopped
    
    var title: String {
        switch self {
        case .searching:
            "Stop"
        case .stopped:
            "Search"
        }
    }
    
    mutating func toggle() {
        self = (self == .searching) ? .stopped : .searching
    }
}
