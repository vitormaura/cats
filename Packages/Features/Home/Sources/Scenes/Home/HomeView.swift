import DesignSystem
import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                LoadingView()
            case .success:
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.widgets, id: \.id) { widget in
                            AnyWidgetView(widget)
                                .onAppear {
                                    viewModel.onAppearWidget(widget)
                                }.onTapGesture {
                                    viewModel.onTapWidget(widget)
                                }
                        }
                    }
                    .padding([.top, .leading, .trailing], 16)
                }
            case .error(let model):
                ErrorView(model: model,
                          action: viewModel.tryAgain)
            }
        }
        .animation(.easeInOut, value: viewModel.viewState)
        .navigationTitle(viewModel.sceneTitle)
        .onAppear {
            viewModel.onAppear()
        }
    }
}
