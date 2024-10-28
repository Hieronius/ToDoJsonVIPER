import UIKit

extension UIView {

	/// Helper function to add an array of views as subviews
	/// - Parameter views: An array of views to be added
	func addSubviews(_ views: [UIView]) {
		views.forEach { self.addSubview($0) }
	}
}
