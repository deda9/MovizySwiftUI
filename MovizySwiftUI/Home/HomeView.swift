import SwiftUI
import Movies
import Search
import Trailers
import NetworkLayer

struct HomeView: View {
    @State private var selectedTab = HomeTabs.home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MoviesView(viewModel: MoviesViewModel(networkService: NetworkService.default)).tabItem { HomeTabs.home.view }.tag(HomeTabs.home)
            SearchView().tabItem { HomeTabs.search.view }.tag(HomeTabs.search)
            TrailersView().tabItem { HomeTabs.trailers.view }.tag(HomeTabs.trailers)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
