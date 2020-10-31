import SwiftUI

public enum LoadingState<Value> {
    case loading
    case loadMore(Value)
    case loaded(Value)
    case failed(String)
}

public protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

public protocol Pager {
    var isLoadingMore: Bool { get }
    var canLoadMore: Bool { get }
    var currentPage: Int { get }
}

public struct AsyncListView<Source: LoadableObject, Placeholder: View, Content: View>: View {
    
    @ObservedObject var source: Source
    var placeholder: Placeholder
    var content: (Source.Output) -> Content
    
    public init(source: Source, placeholder: Placeholder, @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
        self.placeholder = placeholder
    }
    
    public var body: some View {
        switch source.state {
        case .loading:
            placeholder.onAppear(perform: source.load)
        case .failed(let error):
            Text(error)
        case .loaded(let output),
             .loadMore(let output):
            content(output)
        }
    }
}
