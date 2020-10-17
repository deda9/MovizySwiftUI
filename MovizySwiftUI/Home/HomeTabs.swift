import SwiftUI

enum HomeTabs: Int, CaseIterable {
    case home
    case search
    case trailers
}

extension HomeTabs {
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .trailers:
            return "Trailers"
        }
    }
}

extension HomeTabs {
    var icon: String {
        switch self {
        case .home:
            return "film"
        case .search:
            return "viewfinder.circle"
        case .trailers:
            return "video.circle"
        }
    }
}

extension HomeTabs {
    var view: some View {
        return tabBarItem(text: title, image: icon)
    }
}

private extension HomeTabs {
    func tabBarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
}
