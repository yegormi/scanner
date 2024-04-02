import UIKit

class MagneticViewController: UIViewController {
    
    private let totalValue: CGFloat = 100 // Total value for the gauge control
    
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
        
//        // Example usage: Set the gauge value (0-100)
        setGaugeValue(value: 0)
    }
    
    private func setupUI() {
        view.setSubviewsForAutoLayout([
            magneticImageView,
            progressImage,
            arrowView,
            magneticValue,
            searchButton
        ])
        
        NSLayoutConstraint.activate([
            magneticImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            magneticImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            magneticImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            progressImage.topAnchor.constraint(equalTo: magneticImageView.bottomAnchor, constant: 62),
            progressImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            arrowView.topAnchor.constraint(equalTo: progressImage.topAnchor, constant: 154),
            arrowView.leadingAnchor.constraint(equalTo: progressImage.leadingAnchor, constant: 90),
            arrowView.trailingAnchor.constraint(equalTo: progressImage.trailingAnchor, constant: -159),
            
            magneticValue.topAnchor.constraint(equalTo: progressImage.bottomAnchor, constant: 47),
            magneticValue.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            magneticValue.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchButton.topAnchor.constraint(equalTo: magneticValue.bottomAnchor, constant: 87),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setGaugeValue(value: CGFloat) {
        let rotationAngle = value / totalValue * 180 // Calculate the rotation angle based on the value
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle.degreesToRadians)
        arrowView.transform = rotationTransform
    }
    
    private func calculateCenterOffset() -> CGFloat {
        // Calculate the offset to make the right part the center of rotation
        let arrowWidth = arrowView.frame.width
        let progressImageWidth = progressImage.frame.width
        let offset = (progressImageWidth - arrowWidth) / 2
        return offset
    }
    
    @objc private func searchButtonTapped() {
        print("Search toggled")
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { self * .pi / 180 }
}
