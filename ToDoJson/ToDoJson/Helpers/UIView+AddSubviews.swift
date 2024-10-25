import UIKit

extension UIView {

	/// Helper function to add an array of views as subviews
	func addSubviews(_ views: [UIView]) {
		views.forEach { self.addSubview($0) }
	}
}
