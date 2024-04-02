import UIKit

class ResultViewController: UIViewController {
    
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
        number.text = "5"
        view.addArrangedSubview(number)
        
        let label = UILabel()
        label.font = .roboto(.bold, size: 28)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Devices"
        view.addArrangedSubview(label)
        
        return view
    }()
    
    private lazy var wifiName: UILabel = {
        let label = UILabel()
        label.font = .roboto(.regular, size: 15)
        label.textColor = .appGrey
        label.textAlignment = .center
        label.text = "WIFI_Name"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .itemBackground
        tableView.backgroundView?.backgroundColor = .itemBackground
        tableView.separatorStyle = .singleLine
        tableView.set(cornerRadius: 8)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlack
        self.title = "Result"
        if let rootVC = navigationController?.viewControllers.first {
            navigationController?.viewControllers = [rootVC, self]
        }
        setupUI()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DeviceCell.self, forCellReuseIdentifier: DeviceCell.reuseID)
        
        view.setSubviewsForAutoLayout([
            devicesFound,
            wifiName,
            tableView,
        ])
        
        NSLayoutConstraint.activate([
            devicesFound.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            devicesFound.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            wifiName.topAnchor.constraint(equalTo: devicesFound.bottomAnchor),
            wifiName.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wifiName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: wifiName.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Device.mock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.reuseID, for: indexPath) as! DeviceCell
        let device = Device.mock[indexPath.row]
        cell.configure(with: device)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(DetailViewController(device: Device.mock[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
