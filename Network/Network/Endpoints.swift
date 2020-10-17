public enum Endpoints {
    case getPopularList(Int)
    case searchMovie(String, Int)
}

public extension Endpoints {
    
    func resolve() -> URLRequestBuilder {
        switch self {
        case .getPopularList(let page):
            return MoviesAPIs.getPopularList(page)
        case .searchMovie(let text, let page):
            return MoviesAPIs.searchMovie(text, page)
        }
    }
}
