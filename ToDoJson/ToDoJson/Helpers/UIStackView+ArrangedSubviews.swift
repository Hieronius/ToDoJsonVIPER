import UIKit

extension UIStackView {
	
	/// Adds multiple arranged subviews to the stack view.
	/// - Parameter views: An array of views to be added as arranged subviews.
	func addArrangedSubviews(_ views: [UIView]) {
		for view in views {
			self.addArrangedSubview(view)
		}
	}
}
