import SwiftUI

public enum LoadingState<Value> {
    case loading
    case loaded(Value)
    case failed(String)
}

public protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

public struct AsyncListView<Source: LoadableObject, Placeholder: View, Content: View>: View where Source.Output: RandomAccessCollection,
                                                                                                  Source.Output.Element: Hashable {
    
    @ObservedObject var source: Source
    var placeholder: Placeholder
    var content: (Source.Output.Element) -> Content
    
    public init(source: Source, placeholder: Placeholder, @ViewBuilder content: @escaping (Source.Output.Element) -> Content) {
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
        case .loaded(let items):
            List {
                ForEach(items, id: \.self) { item in
                    content(item)
                }
                ProgressView().onAppear(perform: source.load)
            }
        }
    }
}
