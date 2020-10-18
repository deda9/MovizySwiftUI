import SwiftUI
import Coordinator
import Movies
import Search
import Trailers
import NetworkLayer

protocol HomeCoordinating: Coordinator {}

extension HomeCoordinating {
    func route(to route: HomeRoute) -> some View {
        switch route {
        case .movies:
            let networkService = NetworkService.default
            let viewModel = MoviesViewModel(networkService: networkService)
            return AnyView(MoviesView(viewModel: viewModel))
        case .search:
            return AnyView(SearchView())
        case .trailer:
            return AnyView(TrailersView())
        }
    }
}

class HomeCoordinator: HomeCoordinating {}
