import SwiftUI
import Common

struct MoviePosterView: View {
    
    @StateObject var imageDownloader: ImageDownloader
    let size: PosterStyle.Size
    
    var body: some View {
        if let image = imageDownloader.image {
            Image(uiImage: image)
                .resizable()
                .renderingMode(.original)
                .posterStyle(size: .medium)
                .animation(.spring())
        } else {
            Rectangle()
                .foregroundColor(.gray)
                .posterStyle(size: .medium)
        }
    }
}
