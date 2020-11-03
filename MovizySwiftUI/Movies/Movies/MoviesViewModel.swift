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
    private var movies: [Movie] = []
    private var pager: Pagination = Pager()
    
    public var inputs: MoviesViewModelInputs {
        return self
    }
    
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func load() {
        guard pager.canLoadMore else { return }

        self.pager.state = .loading

        self.networkService
            .execute(Endpoints.getPopularList(self.pager.nextPage).resolve(), model: MoviesResponse.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.movies.append(contentsOf: response.movies)
                    self.state = .loaded(self.movies)
                    self.pager.totalItems = response.totalPages
                    self.pager.state = .finished
                    
                case .failure(let error):
                    self.state = .failed(error.localizedDescription)
                    self.pager.state = .finished
                }
            }.store(in: &bag)
    }
}
