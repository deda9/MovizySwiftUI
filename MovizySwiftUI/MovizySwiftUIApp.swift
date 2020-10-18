import SwiftUI
import Coordinator

@main
struct MovizySwiftUIApp: App {
    
    private let coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            return coordinator.route(to: .home)
        }
    }
}

