import SwiftUI

open class ViewController<Content: View>: UIHostingController<Content> {
    public var hidesNavigationBarWhenPushed = false

    public override init(rootView: Content) {
        super.init(rootView: rootView)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        print("deinit ----> \(self)")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(hidesNavigationBarWhenPushed, animated: animated)
        setupNavigationAppearance()
    }

    public func setupNavigationAppearance() {
        navigationItem.backButtonTitle = ""
        let navController = navigationController as? NavigationController
        navController?.setupLargeTitles()
        navController?.setupAppearance()
    }
}

