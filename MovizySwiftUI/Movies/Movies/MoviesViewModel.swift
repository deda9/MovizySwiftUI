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

public final class MoviesViewModel: MoviesViewModelProtocol, MoviesViewModelInputs, Pager {
    @Published public var state: LoadingState<[Movie]> = .loading
    
    private var networkService: NetworkServiceProtocol!
    private var bag: [AnyCancellable] = []
    private var movies: [Movie] = []
    
    public var currentPage: Int = 0
    public var canLoadMore: Bool = true
    public var isLoadingMore: Bool = false
    public var inputs: MoviesViewModelInputs {
        return self
    }
    
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func load() {
        guard canLoadMore, !isLoadingMore else { return }
        
        self.currentPage += 1
        
        if self.currentPage == 1 {
            self.state = .loading
            self.isLoadingMore = false
        } else {
            self.state = .loadMore(self.movies)
            self.isLoadingMore = true
        }
        
        self.networkService
            .execute(Endpoints.getPopularList(self.currentPage).resolve(), model: MoviesResponse.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let moviesResponse):
                    self.movies.append(contentsOf: moviesResponse.getMovies())
                    self.state = .loaded(self.movies)
                    self.canLoadMore = self.movies.count / self.currentPage >= 20
                    self.isLoadingMore = false
                    
                case .failure(let error):
                    self.state = .failed(error.localizedDescription)
                }
            }.store(in: &bag)
    }
}
