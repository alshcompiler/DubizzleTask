//
//  ImageLoader.swift
//  ImageCaching
//
//  Created by Mostafa.Sultan on 10/13/21.
//

import Foundation
import UIKit.UIImage

public final class ImageCaching {
    
    private let cache = NSCache<NSString, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    public static let shared = ImageCaching()
    
    public func loadImage(url: String, imageView: UIImageView, placeholder: UIImage) {
        imageView.image = placeholder
        if let cachedImage = self.cache.object(forKey: url as NSString) {
            print("Using a cached image for item:")
            imageView.image = cachedImage
        } else {
            self.loadImageFromURL(url: url) { [weak self] (image) in
                guard let self = self, let image = image else {
                    imageView.image = placeholder
                    return
                }
                self.cache.setObject(image, forKey: url as NSString)
                
                UIView.transition(with: imageView ,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    imageView.image =  image },
                                  completion: nil)
            }
        }
    }
    
    private func loadImageFromURL(url: String, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = URL(string: url)!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
