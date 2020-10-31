import Common

public struct Movie: Codable, Identifiable, Hashable {
    public let id: Int
    public let voteCount: Int
    public let video: Bool
    public let voteAverage: Double
    public let title: String
    public let popularity: Double
    public let posterPath, originalTitle: String?
    public let originalLanguage: String?
    public let genreIDS: [Int]
    public let backdropPath: String?
    public let adult: Bool
    public let overview, releaseDate: String
    public var imageUrl: String? {
        return Path.Movies.imageBaseUrl + (self.posterPath ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
