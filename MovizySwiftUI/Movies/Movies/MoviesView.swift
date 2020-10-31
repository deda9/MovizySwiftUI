//
//  MoviesView.swift
//  MovizySwiftUI
//
//  Created by Deda on 18.10.20.
//

import SwiftUI
import Common
import Models

public struct MoviesView<ViewModel>: View where ViewModel: MoviesViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        AsyncListView(source: viewModel, placeholder: Placeholder()) {
            Contentview(movies: $0, loadMore: viewModel.load)
        }
    }
}

extension MoviesView {
    struct Contentview: View {
        var movies: [Movie]
        var loadMore: () -> Void
        
        var body: some View {
            List {
                ForEach(movies, id: \.self) { movie in
                    MovieCard(movie: movie)
                }
                ProgressView().onAppear(perform: loadMore)
            }
        }
    }
}

extension MoviesView {
    struct Placeholder: View {
        var body: some View {
            LoadingView {
                Text(Translations.moviesLoadingText)
            }
        }
    }
}
