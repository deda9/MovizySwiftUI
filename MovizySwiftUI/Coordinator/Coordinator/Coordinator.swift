import SwiftUI

public protocol Coordinator {
    associatedtype RouteType: Route
    associatedtype T: View
    func route(to route: RouteType) -> T
}
