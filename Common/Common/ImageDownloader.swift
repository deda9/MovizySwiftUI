//
//  ImageDownloader.swift
//  Common
//
//  Created by Deda on 19.10.20.
//

import SwiftUI
import Kingfisher

public protocol ImageDownloading: ObservableObject {
    var url: NSString? { get set }
    var image: UIImage? { get set }
    var errorMessage: String? { get set }
    
    func downloadImage(url: String?)
}

extension ImageDownloading {
    public func downloadImage(url: String?) {
        guard let urlString = url else { return }
        guard let downloadURL = URL(string: urlString) else { return }
        self.url = NSString(string: urlString)
        let imageResource = ImageResource(downloadURL: downloadURL, cacheKey: url)
        
        KingfisherManager.shared.retrieveImage(with: imageResource) { result in
            switch result {
            case .success(let response):
                self.image = response.image
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

public class ImageDownloader: ImageDownloading {
    
    @Published public var image: UIImage? = nil
    @Published public var errorMessage: String? = nil
    public var url: NSString? = nil
}

extension ImageDownloader {
    
    public class Cache {
        private static var imageDownloaders: NSCache<NSString, ImageDownloader> = NSCache()
        
        public class func instnace(url: String?) -> ImageDownloader {
            guard let url = url else {
                return ImageDownloader()
            }
            
            if let imageDownloader = imageDownloaders.object(forKey: NSString(string: url)) {
                return imageDownloader
            }
            let imageDownloader = ImageDownloader()
            imageDownloaders.setObject(imageDownloader, forKey: NSString(string: url))
            return imageDownloader
        }
    }
}
