import UIKit

public enum RobotoFont: String, CaseIterable {
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case bold = "Roboto-Bold"
}

public extension UIFont {
    static func roboto(_ roboto: RobotoFont, size: CGFloat) -> UIFont {
        UIFont(name: roboto.rawValue, size: size)!
    }
}
