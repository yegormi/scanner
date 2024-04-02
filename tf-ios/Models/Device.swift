import UIKit

struct Device {
    let wifiName: WifiName
    let ipAddress: IPAddress
    let connectionType: ConnectionType
    let macAddress: MACAddress
    let hostname: Hostname
    let state: State
    
    var icon: UIImage {
        switch state {
        case .success:
            return UIImage(named: "cellWifiSuccess")!
        case .fail:
            return UIImage(named: "cellWifiFail")!
        }
    }
    
    var image: UIImage {
        switch state {
        case .success:
            return UIImage(named: "wifiSuccess")!
        case .fail:
            return UIImage(named: "wifiFail")!
        }
    }
    
    enum State {
        case success
        case fail
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
            guard !value.isEmpty else {
                return nil
            }
            self.value = value
        }
    }
    
    struct IPAddress {
        let value: String
        
        init?(_ value: String) {
            guard isValidIPAddress(value) else {
                return nil
            }
            self.value = value
        }
        
        
    }
    
    struct MACAddress {
        let value: String
        
        init?(_ value: String) {
            guard isValidMACAddress(value) else {
                return nil
            }
            self.value = value
        }
    }
    
    struct Hostname {
        let value: String
        
        init?(_ value: String) {
            guard !value.isEmpty else {
                return nil
            }
            self.value = value
        }
    }
}

fileprivate func isValidMACAddress(_ value: String) -> Bool {
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

fileprivate func isValidIPAddress(_ value: String) -> Bool {
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
