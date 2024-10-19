import UIKit

extension UIView {

	/// Helper function to wrap TAMIC set to false for an array of `UIView`
	func disableAutoresizingMask(_ views: [UIView]) {
		views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}
}
