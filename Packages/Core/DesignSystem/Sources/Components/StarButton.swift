import SwiftUI

public struct StarButton: View {
    @State private var isStarred: Bool
    var action: (() -> Void)?

    public init(isStarred: Bool = false, action: (() -> Void)? = nil) {
        self.isStarred = isStarred
        self.action = action
    }

    public var body: some View {
        Button(action: {
            withAnimation {
                action?()
                isStarred.toggle()
            }
        }) {
            Image(systemName: isStarred ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(isStarred ? Color(.label) : .gray)
                .animation(.easeInOut, value: isStarred)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
