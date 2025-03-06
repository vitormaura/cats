import Foundation
import RouterProtocol

struct TabBarContent: Codable {
    let tabs: [Tab]

    init(tabs: [Tab]) {
        self.tabs = tabs
    }
}

