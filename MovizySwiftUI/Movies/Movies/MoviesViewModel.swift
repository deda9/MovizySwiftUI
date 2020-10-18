import Models
import NetworkLayer
import Combine
import Foundation

public enum MoviesLoadingState {
    case loading
    case finished(movies: [Movie])
    case error(message: String)
}

public protocol MoviesViewModelInputs {
    var loadingState: MoviesLoadingState { get }
}

public protocol MoviesViewModelProtocol: ObservableObject {
    var inputs: MoviesViewModelInputs { get }
}

public final class MoviesViewModel: MoviesViewModelProtocol, MoviesViewModelInputs {
    
    @Published public var loadingState: MoviesLoadingState = .loading
    
    private var networkService: NetworkServiceProtocol!
    private var bag: [AnyCancellable] = []
    
    let page = 1
    
    public var inputs: MoviesViewModelInputs {
        return self
    }
    
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.fetchMovies()
    }
    
    private func fetchMovies() {
        self.loadingState = .loading
        
        let request =
            self.networkService.execute(Endpoints.getPopularList(page).resolve(), model: MoviesResponse.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let moviesResponse):
                    self.loadingState = .finished(movies: moviesResponse.getMovies())
                    
                case .failure(let error):
                    self.loadingState = .error(message: error.localizedDescription)
                }
            }
        request.store(in: &bag)
    }
}
