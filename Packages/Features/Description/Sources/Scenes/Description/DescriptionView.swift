import DesignSystem
import SwiftUI

struct DescriptionView<ViewModel: DescriptionViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Group {
            VStack(spacing: 24) {
                ImageView(urlString: viewModel.imageURL,
                          placeholder: .init(systemName: "cat.fill"))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 240, height: 240)
                    .clipShape(RoundedRectangle(cornerSize: .init(width: 16, height: 16)))
                    .shadow(radius: 8)
                VStack(spacing: 12) {
                    Text(viewModel.origin)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 12)
                        .bold()
                    Text(viewModel.temperament)
                        .multilineTextAlignment(.center)
                    Text(viewModel.description)
                        .multilineTextAlignment(.center)
                }
                StarButton(isStarred: viewModel.isFavorite, action: {
                    viewModel.buttonAction()
                })
            }
            .padding(28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        .navigationTitle(viewModel.sceneTitle)
    }
}
