import DesignSystem
import SwiftUI

struct FavouritesView<ViewModel: FavouritesViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]

    var body: some View {
        Group {
            if viewModel.favourites.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: viewModel.emptyImage)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.orange)
                        .frame(width: 100, height: 80)
                        .aspectRatio(contentMode: .fit)
                    Text(viewModel.emptyMessage)
                        .font(.headline)
                }
                .padding(32)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.favourites, id: \.id) { favourite in
                            CardView(imageURL: favourite.imageURL,
                                     placeholder: .init(systemName: "cat.fill"),
                                     title: favourite.breedName,
                                     isFavourite: favourite.isFavourite,
                                     buttonAction: {
                                viewModel.buttonAction(favourite)
                            }).onTapGesture {
                                viewModel.onTapCard(favourite)
                            }
                        }
                    }
                    .padding([.top, .leading, .trailing], 16)
                }
            }
        }
        .navigationTitle(viewModel.sceneTitle)
        .onAppear {
            viewModel.onAppear()
        }
    }
}
