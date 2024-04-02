import UIKit

protocol NavigationCardDelegate: AnyObject {
    func didSelectCard(at index: Int)
}

class NavigationCardView: UIView {
    private let columnView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 38
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var cards: [NavigationCard] = [] {
        didSet {
            setupGrid()
        }
    }
    
    weak var delegate: NavigationCardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGrid()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.setSubviewForAutoLayout(columnView)
        
        NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: topAnchor),
            columnView.leadingAnchor.constraint(equalTo: leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupGrid() {
        var rowStackView: UIStackView?
        
        for (index, card) in cards.enumerated() {
            if index % 2 == 0 {
                rowStackView = createRowStackView()
            }
            let cardButton = createCell(card, atIndex: index)
            rowStackView?.addArrangedSubview(cardButton)
        }
    }
    
    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 38
        rowStackView.alignment = .fill
        rowStackView.distribution = .fillEqually
        columnView.addArrangedSubview(rowStackView)
        return rowStackView
    }
    
    @objc private func cardTapped(_ sender: UIButton) {
        let index = sender.tag
        delegate?.didSelectCard(at: index)
    }
    
    private func createCell(_ card: NavigationCard, atIndex index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = index
        button.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
        
        button.backgroundColor = .itemBackgroundCard
        button.set(cornerRadius: 8)
        
        addSubviewsToButton(button, with: card)
        
        return button
    }
    
    private func addSubviewsToButton(_ button: UIButton, with card: NavigationCard) {
        let iconImageView = UIImageView(image: card.icon)
        iconImageView.contentMode = .scaleAspectFit
        button.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = card.title
        titleLabel.font = .roboto(.medium, size: 17)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        button.addSubview(titleLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 24),
            iconImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -30),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -24)
        ])
    }
}
