import SwiftUI

public struct ErrorModel {
    var imageName: String
    var title: String
    var subtitle: String
    var buttonTitle: String
    
    public init(imageName: String = "hand.thumbsdown",
                title: String = "Oops!",
                subtitle: String = "Something went wrong.",
                buttonTitle: String = "Try again") {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
}

public struct ErrorView: View {
    var model: ErrorModel
    @State private var isLoading = false
    private let tryAgainAction: (() -> Void)?

    public init(model: ErrorModel = ErrorModel(),
                action: (() -> Void)? = nil) {
        self.model = model
        self.tryAgainAction = action
    }

    public var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack(spacing: 36) {
                Spacer()
                Image(systemName: model.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.orange)
                    .frame(width: 100, height: 100)
                VStack(spacing: 8) {
                    Text(model.title)
                        .font(.title)
                        .foregroundColor(Color(.label))
                        .bold()
                    Text(model.subtitle)
                        .font(.title3)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.center)
                }
                Spacer()
                Button(action: tryAgainAction ?? { }) {
                    Text(model.buttonTitle)
                        .font(.headline)
                        .foregroundColor(Color(.systemBlue))
                        .padding()
                        .bold()
                }
                .padding(.bottom, 32)
            }
            .padding(32)
        }
    }
}

#Preview {
    ErrorView()
}
