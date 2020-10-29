import Models
import NetworkLayer
import Combine
import Foundation
import Common

public protocol MoviesViewModelInputs {
    var state: LoadingState<[Movie]> { get }
}

public protocol MoviesViewModelProtocol: LoadableObject where Output == [Movie] {
    var inputs: MoviesViewModelInputs { get }
}

public final class MoviesViewModel: MoviesViewModelProtocol, MoviesViewModelInputs {
    
    @Published public var state: LoadingState<[Movie]> = .loading
    
    private var networkService: NetworkServiceProtocol!
    private var bag: [AnyCancellable] = []
    
    let page = 1
    
    public var inputs: MoviesViewModelInputs {
        return self
    }
    
    var bar: [AnyCancellable] = []
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func load() {
        self.state = .loading
        self.networkService
            .execute(Endpoints.getPopularList(page).resolve(), model: MoviesResponse.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let moviesResponse):
                    self.state = .loaded(moviesResponse.getMovies())
                    
                case .failure(let error):
                    self.state = .failed(error.localizedDescription)
                }
            }.store(in: &bag)
    }
}
