import SwiftUI

public struct LoadingView: View {
    @State private var isLoading = false
    private let width: CGFloat
    private let height: CGFloat
    private let lineWidth: CGFloat
    private let color: Color
    private let hasBackground: Bool
    private let isOpaque: Bool
    
    public init(width: CGFloat = 75,
                height: CGFloat = 75,
                lineWidth: CGFloat = 4,
                color: Color = .orange,
                hasBackground: Bool = true,
                isOpaque: Bool = false) {
        self.width = width
        self.height = height
        self.lineWidth = lineWidth
        self.color = color
        self.hasBackground = hasBackground
        self.isOpaque = isOpaque
    }

    public var body: some View {
        ZStack {
            if hasBackground {
                Color(.systemBackground)
                    .opacity(isOpaque ? 1.0 : 0.6)
                    .ignoresSafeArea()
            }
            Circle()
                .stroke(Color(.lightGray.withAlphaComponent(0.2)), lineWidth: lineWidth * 2)
                .frame(width: width, height: height)
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(color, lineWidth: lineWidth)
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false),
                           value: isLoading)
                .onAppear() {
                    withAnimation {
                        self.isLoading.toggle()
                    }
                }
        }
    }
}

#Preview {
    LoadingView()
}
