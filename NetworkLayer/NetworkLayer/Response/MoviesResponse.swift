import Models

public struct MoviesResponse: Codable {
    let page, totalResults, totalPages: Int
    let moviesList: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case moviesList = "results"
    }
    
    public func getMovies() -> [Movie] {
        return moviesList
    }
}
