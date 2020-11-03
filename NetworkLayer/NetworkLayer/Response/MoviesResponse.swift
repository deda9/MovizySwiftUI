import Models

public struct MoviesResponse: Codable {
    public let page, totalResults, totalPages: Int
    public let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
