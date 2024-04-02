import UIKit

class MagneticViewController: UIViewController {
    
    private let totalValue: CGFloat = 100
    private let animationDuration: TimeInterval = 2.0
    private var state: State = .stopped {
        didSet {
            updateSearchButton()
        }
    }
    private var gaugeValue: CGFloat = 0
    
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
    
    private lazy var gaugeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .roboto(.medium, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.set(cornerRadius: 25)
        button.setBackgroundColor(.purplePrimary, for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.titleLabel?.font = .roboto(.medium, size: 20)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        updateSearchButton()
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
            gaugeValueLabel,
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
            
            gaugeValueLabel.topAnchor.constraint(equalTo: progressImage.bottomAnchor, constant: 47),
            gaugeValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gaugeValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchButton.topAnchor.constraint(equalTo: gaugeValueLabel.bottomAnchor, constant: 87),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setGaugeValue(value: CGFloat) {
        gaugeValue = value
        gaugeValueLabel.text = "\(Int(value))"
        
        let rotationAngle = value / totalValue * 180
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle.degreesToRadians)
        arrowView.transform = rotationTransform
    }
    
    private func updateSearchButton() {
        searchButton.setTitle(state.rawValue, for: .normal)
    }
    
    @objc private func searchButtonTapped() {
        if state == .stopped {
            state = .searching
            animateArrow(with: 50)
        } else {
            state = .stopped
            animateArrow(with: 0)
        }
    }
    
    private func animateArrow(with value: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.setGaugeValue(value: value)
        }
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { self * .pi / 180 }
}

fileprivate enum State: String {
    case searching = "Stop"
    case stopped = "Search"
}
