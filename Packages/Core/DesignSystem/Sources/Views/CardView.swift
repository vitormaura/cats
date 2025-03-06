import SwiftUI

public struct CardView: View {
    var imageURL: String?
    var placeholder: UIImage?
    var title: String
    var isFavourite: Bool
    var buttonAction: (() -> Void)?

    public init(imageURL: String?,
                placeholder: UIImage?,
                title: String,
                isFavourite: Bool,
                buttonAction: (() -> Void)?) {
        self.imageURL = imageURL
        self.placeholder = placeholder
        self.title = title
        self.isFavourite = isFavourite
        self.buttonAction = buttonAction
    }

    public var body: some View {
        Group {
            VStack(spacing: 24) {
                ImageView(urlString: imageURL,
                          placeholder: placeholder)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
                Text(title)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                StarButton(isStarred: isFavourite, action: buttonAction)
            }
            .padding(28)
        }
        .background(Color.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.orange, lineWidth: 2)
                .shadow(radius: 4)
        )
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
}
