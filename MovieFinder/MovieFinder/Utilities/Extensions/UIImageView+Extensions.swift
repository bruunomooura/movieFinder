//
//  UIImageView+Extensions.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import Foundation
import UIKit

extension UIImageView {
    /// Loads an image from a specified URL string.
    ///
    /// This function fetches an image from the provided URL and sets it to the image view. It also handles errors related to the URL and image loading process.
    ///
    /// - Parameters:
    ///   - urlString: A string representing the URL of the image to be loaded.
    ///   - completion: An optional closure that is called upon completion of the image loading process. It returns a `Result<UIImage, Error>` indicating success or failure.
    ///
    /// - Note: If the URL is invalid or if there is an error during the download or conversion of data to an image, the completion handler is called with an error.
    func loadImageFromURL(_ urlString: String, completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            completion?(.failure(ImageLoadingError.unknownError))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error converting data to image.")
                DispatchQueue.main.async {
                    completion?(.failure(ImageLoadingError.unknownError))
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
                self.contentMode = .scaleAspectFill
                completion?(.success(image))
            }
        }
        task.resume()
    }
}

// Enum that represents the possible errors that may occur when loading an image
enum ImageLoadingError: Swift.Error {
    case unknownError
}
