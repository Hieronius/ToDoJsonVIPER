import UIKit

/// A wrapper to automatically use `RootView` with Controller by `rootView` property
class GenericViewController<T: UIView>: UIViewController {

	// MARK: - Public Properties

	public var rootView: T {
		return view as! T
	}

	// MARK: - Public Methods

	override open func loadView() {
		self.view = T()
	}
}
