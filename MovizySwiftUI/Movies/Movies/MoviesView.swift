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
        switch viewModel.inputs.loadingState {
        case .loading:
            LoadingView {
                Text(Translations.moviesLoadingText)
            }
            
        case .finished(let movies):
            List(movies) { movie in
                MovieRow(movie: movie)
            }
        case .error(let message):
            Text(message)
        }
    }
}
