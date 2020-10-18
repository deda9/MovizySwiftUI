import Models
import NetworkLayer
import Combine
import Foundation

public protocol MoviesViewModelInputs {
    var movies: [Movie] { get }
    var errorMessage: String? { get }
    var isLoading: Bool { get }
}

enum MoviesLoadingState {
    case loading
    case finished
    case error
}

public protocol MoviesViewModelProtocol: ObservableObject {
    var inputs: MoviesViewModelInputs { get }
}

public final class MoviesViewModel: MoviesViewModelProtocol, MoviesViewModelInputs {
    
    @Published public var movies: [Movie] = []
    @Published public var errorMessage: String?
    @Published public var isLoading: Bool = false
    
    var bag: [AnyCancellable] = []
    let page = 1
    
    public var inputs: MoviesViewModelInputs {
        return self
    }
    
    public init() {
            self.fetchMovies()
    }
    
    private func fetchMovies() {
        self.isLoading = true
        
        let request =
            NetworkService<MoviesResponse>.execute(Endpoints.getPopularList(page).resolve()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let moviesResponse):
                    self.isLoading = false
                    self.movies = moviesResponse.getMovies()
                    
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.errorDescription
                }
            }
        request.store(in: &bag)
    }
}
