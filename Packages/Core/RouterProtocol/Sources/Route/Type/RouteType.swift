import SwiftUI

public enum RouteType {
    case present
    case push
    case pushAsFirst
    case pushFromFirst
    case dismiss
    case popToIfPossible
}

extension RouteType: Equatable {
    public static func == (lhs: RouteType, rhs: RouteType) -> Bool {
        switch (lhs, rhs) {
        case (.present, .present),
             (.push, .push),
             (.pushAsFirst, .pushAsFirst),
             (.pushFromFirst, .pushFromFirst),
             (.dismiss, .dismiss),
             (.popToIfPossible, .popToIfPossible):
            return true
        default:
            return false
        }
    }
}

