public protocol Route {}

public enum AppRoute: Route {
    case home
}

public enum HomeRoute: Route {
    case movies
    case search
    case trailer
}
