import UIKit

extension UIView {
	func disableAutoresizingMask(for views: [UIView]) {
		views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}
}
