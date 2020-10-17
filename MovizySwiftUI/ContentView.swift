//
//  ContentView.swift
//  MovizySwiftUI
//
//  Created by Deda on 17.10.20.
//

import SwiftUI

//import NetworkLayer
import Models
import Combine
import NetworkLayerk

struct ContentView: View {
    @ObservedObject var viewx = VIEWMOL()
    
    var body: some View {
        NavigationView {
            List(viewx.movies) { item in
                Text(item.getTitle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class VIEWMOL: ObservableObject {
    var tokens: Set<AnyCancellable> = []
    @Published var movies: [Movie] = []
    
    init() {
        cc()
    }
    
    func cc()  {
//
        let xx = NetworkService<MoviesResponse>.execute(Endpoints.getPopularList(1).resolve()) { result in
            switch result {
            case .success(let moviesResponse):
                self.movies = moviesResponse.getMovies()
                print(moviesResponse.getMovies())
            case .failure(let _):
                print("error.errorDescription")
            }

        }
        xx.store(in: &tokens)
    }
}
