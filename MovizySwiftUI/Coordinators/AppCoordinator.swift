import SwiftUI
import Coordinator

protocol AppCoordinating: Coordinator {}

extension AppCoordinating {
    func route(to route: AppRoute) -> some View {
        let coordinator = HomeCoordinator()
        return HomeView(coordinator: coordinator)
    }
}

class AppCoordinator: AppCoordinating {}
