import UIKit

class RoundCornerButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
    }
}

class MagneticViewController: UIViewController {
    
    private var currentValue: CGFloat = 0
    private let totalValue: CGFloat = 100
    private let animationDuration: TimeInterval = 2.0
    
    private var state: State = .stopped {
        didSet {
            updateLabels()
        }
    }
    
    private lazy var backgroundCard: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundCard")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var magneticImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "magnetic")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var progressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "magneticProgress")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "magneticArrow")
//        imageView.layer.anchorPoint = CGPoint(x: 0.6, y: 0.5)
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
    
    private lazy var searchButton: RoundCornerButton = {
        let button = RoundCornerButton(type: .system)
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
        
        setGaugeValue(value: 0, around: CGPoint(x: 0, y: 0))
    }
    
    private func setupUI() {
        view.setSubviewsForAutoLayout([
            backgroundCard,
            magneticImage,
            progressImage,
            arrowView,
            magneticValue,
            searchButton,
        ])
        
        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundCard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            magneticImage.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            magneticImage.centerYAnchor.constraint(equalTo: backgroundCard.centerYAnchor),
            magneticImage.heightAnchor.constraint(equalTo: backgroundCard.heightAnchor, multiplier: 0.5),
            
            progressImage.topAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: 62),
            progressImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            arrowView.topAnchor.constraint(equalTo: progressImage.topAnchor, constant: 154),
            arrowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arrowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            magneticValue.topAnchor.constraint(equalTo: progressImage.bottomAnchor, constant: 47),
            magneticValue.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            magneticValue.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchButton.topAnchor.constraint(equalTo: magneticValue.bottomAnchor, constant: 87),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func rotateView(view: UIView, angle: CGFloat, aroundPoint rotationCenter: CGPoint) {
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        view.layer.anchorPoint = CGPoint(x: rotationCenter.x / view.bounds.width, y: rotationCenter.y / view.bounds.height)
        view.transform = rotationTransform
    }
    
    private func setGaugeValue(value: CGFloat, around point: CGPoint? = nil) {
        let rotationAngle = value / totalValue * 180
        let rotationCenter = CGPoint(x: arrowView.bounds.midX + 35, y: arrowView.bounds.midY)
        rotateView(view: self.arrowView, angle: rotationAngle.degreesToRadians, aroundPoint: point ?? rotationCenter)
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
