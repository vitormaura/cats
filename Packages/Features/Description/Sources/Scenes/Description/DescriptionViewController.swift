import DesignSystem
import SwiftUI

final class DescriptionViewController<Content: View>: ViewController<Content> {
    override init(rootView: Content) {
        super.init(rootView: rootView)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
