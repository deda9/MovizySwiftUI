import SwiftUI
import Common
import Models
 
 struct MovieRow: View {
    let movie: Movie
    
    var imageDownloader: ImageDownloader {
        let imageDownloader = ImageDownloader.Cache.instnace(url: self.movie.imageUrl)
        imageDownloader.downloadImage(url: self.movie.imageUrl)
        return imageDownloader
    }
    
    var body: some View {
        HStack {
            MoviePosterView(imageDownloader: imageDownloader, size: .medium)
        }
    }
 }
