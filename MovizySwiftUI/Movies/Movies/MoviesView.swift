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
        if viewModel.inputs.isLoading {
            LoadingView {
                Text(Translations.moviesLoadingText)
            }
        } else {
            List(viewModel.inputs.movies) { movie in
                Text(movie.getTitle())
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: MoviesViewModel())
    }
}
