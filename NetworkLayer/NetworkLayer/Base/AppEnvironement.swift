import Foundation

enum AppEnvironement {
    case production
    case development
}

extension AppEnvironement {
    static var currentState: AppEnvironement {
        return .development
    }
}

//swiftlint:disable force_unwrapping
extension AppEnvironement {
    static var baseURL: URL {
        switch AppEnvironement.currentState {
        case .production:
            return URL(string: Servers.production)!
        case .development:
            return URL(string: Servers.development)!
        }
    }
}

extension AppEnvironement {
    static var showLog: Bool {
        switch AppEnvironement.currentState {
        case .production:
            return false
        case .development:
            return true
        }
    }
}
