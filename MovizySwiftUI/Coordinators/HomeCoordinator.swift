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
            return AnyView(
                MoviesView(viewModel: viewModel)
                    .withNavigation(title: HomeTabs.home.title))
        case .search:
            return AnyView(SearchView()
                            .withNavigation(title: HomeTabs.search.title))
        case .trailer:
            return AnyView(TrailersView()
                            .withNavigation(title: HomeTabs.trailers.title))
        }
    }
}

class HomeCoordinator: HomeCoordinating {}

extension View {
    func withNavigation(title: String) -> some View {
        NavigationView {
            self.navigationBarTitle(title)
        }
    }
}
