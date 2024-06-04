import UIKit

enum AppVKСolor {
   static let forBackground = UIColor.createColor(
        lightMode: .white,
        darkMode: .darkGray
    )
    static let forText = UIColor.createColor(
        lightMode: .black,
        darkMode: .white
    )
    static let lightGray = UIColor.createColor(
        lightMode: .systemGray,
        darkMode: .systemGray
    )
}
extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
}
