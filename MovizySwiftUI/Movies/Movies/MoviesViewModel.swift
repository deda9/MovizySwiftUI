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
                    delay(seconds: 3, thread: .main) {
                        
                    
                    self.isLoading = false
                    self.movies = moviesResponse.getMovies()
                    
                    }
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.errorDescription
                }
            }
        request.store(in: &bag)
    }
}


enum DelayThread {
    case background(DispatchQoS.QoSClass)
    case main
}

func delay(seconds: Double, thread: DelayThread, execute: @escaping @convention(block) () -> Void) {
    switch thread {
    case .main:
        DispatchQueue.main.asyncAfter(seconds: seconds, execute: execute)
    case .background(let qos):
        DispatchQueue.global(qos: qos).asyncAfter(seconds: seconds, execute: execute)
    }
}

func delay(seconds: Int, thread: DelayThread, execute: @escaping @convention(block) () -> Void) {
    switch thread {
    case .main:
        DispatchQueue.main.asyncAfter(seconds: seconds, execute: execute)
    case .background(let qos):
        DispatchQueue.global(qos: qos).asyncAfter(seconds: seconds, execute: execute)
    }
}

extension DispatchQueue {
    func asyncAfter(seconds: Int, qos: DispatchQoS = .default, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime(seconds), qos: qos, execute: work)
    }
    
    func asyncAfter(seconds: Int, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime(seconds), execute: work)
    }
    
    func asyncAfter(seconds: Double, qos: DispatchQoS = .default, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime(seconds), qos: qos, execute: work)
    }
    
    func asyncAfter(seconds: Double, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime(seconds), execute: work)
    }
}

extension DispatchTime {
    public init(_ value: Int) {
        self = .now() + .seconds(value)
    }
    
    public init(_ value: Double) {
        self = .now() + .milliseconds(Int(value * 1000))
    }
}
