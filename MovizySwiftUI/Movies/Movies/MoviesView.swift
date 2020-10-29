//
//  MoviesView.swift
//  MovizySwiftUI
//
//  Created by Deda on 18.10.20.
//

import SwiftUI
import Common

public struct MoviesView<ViewModel>: View where ViewModel: MoviesViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        AsyncListView(source: viewModel) { movies in
            List(movies) { movie in
                MovieCard(movie: movie)
            }
        }
    }
}
