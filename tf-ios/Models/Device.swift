import UIKit

struct Device {
    let wifiName: WifiName
    let ipAddress: IPAddress
    let connectionType: ConnectionType
    let macAddress: MACAddress
    let hostname: Hostname
    let state: State
    
    var icon: UIImage {
        return state.icon
    }
    
    var image: UIImage {
        return state.image
    }
    
    enum State {
        case success
        case fail
        
        var icon: UIImage {
            switch self {
            case .success:
                return UIImage(named: "cellWifiSuccess")!
            case .fail:
                return UIImage(named: "cellWifiFail")!
            }
        }
        
        var image: UIImage {
            switch self {
            case .success:
                return UIImage(named: "wifiSuccess")!
            case .fail:
                return UIImage(named: "wifiFail")!
            }
        }
    }
}

extension Device {
    enum ConnectionType: String {
        case wifi = "Wi-Fi"
        case ethernet = "Ethernet"
    }
    
    struct WifiName {
        let value: String
        
        init?(_ value: String) {
            self.value = value
            guard !value.isEmpty else {
                return nil
            }
        }
    }
    
    struct IPAddress {
        let value: String
        
        init?(_ value: String) {
            self.value = value
            guard isValidIPAddress(value) else {
                return nil
            }
        }
        
        private func isValidIPAddress(_ value: String) -> Bool {
            let components = value.components(separatedBy: ".")
            guard components.count == 4 else {
                return false
            }
            for component in components {
                guard let number = Int(component), (0...255).contains(number) else {
                    return false
                }
            }
            return true
        }
    }
    
    struct MACAddress {
        let value: String
        
        init?(_ value: String) {
            self.value = value
            guard isValidMACAddress(value) else {
                return nil
            }
        }
        
        private func isValidMACAddress(_ value: String) -> Bool {
            let components = value.components(separatedBy: ":")
            guard components.count == 6 else {
                return false
            }
            for component in components {
                guard component.count == 2, Int(component, radix: 16) != nil else {
                    return false
                }
            }
            return true
        }
    }
    
    struct Hostname {
        let value: String
        
        init?(_ value: String) {
            self.value = value
            guard !value.isEmpty else {
                return nil
            }
        }
    }
}
