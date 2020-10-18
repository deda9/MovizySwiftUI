import SwiftUI
import Coordinator

struct HomeView: View {
  
    private var coordinator: HomeCoordinator!
    @State private var selectedTab = HomeTabs.home
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            self.coordinator.route(to: .movies).tabItem { HomeTabs.home.view }.tag(HomeTabs.home)
            self.coordinator.route(to: .search).tabItem { HomeTabs.search.view }.tag(HomeTabs.search)
            self.coordinator.route(to: .trailer).tabItem { HomeTabs.trailers.view }.tag(HomeTabs.trailers)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coordinator: HomeCoordinator())
    }
}
