import Kingfisher

extension UIImageView {
    func setImage(
        from urlString: String?,
        placeholder: UIImage? = nil,
        isLoader: Bool = false,
        completion: ((Swift.Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        self.kf.indicatorType = isLoader ? .activity : .none

        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            completion?(.failure(.requestError(reason: .emptyRequest)))
            return
        }

        let resizingProcessor = DownsamplingImageProcessor(size: self.bounds.size)

        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.processor(resizingProcessor), .scaleFactor(UIScreen.main.scale)],
            progressBlock: nil
        ) { result in
            self.kf.indicatorType = .none
            completion?(result)
        }
    }
}

//===============//

import Kingfisher

extension UIImageView {
    
    /// Loads an image from a URL string with Kingfisher and applies optional processing.
    /// - Parameters:
    ///   - urlString: The URL string of the image.
    ///   - placeholder: A placeholder image displayed while loading.
    ///   - showLoader: A Boolean to show a loading indicator.
    ///   - completion: A completion handler that returns the result of the image retrieval.
    func loadImage(
        from urlString: String?,
        placeholder: UIImage? = nil,
        showLoader: Bool = false,
        completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        // Show loader if enabled
        self.kf.indicatorType = showLoader ? .activity : .none
        
        // Validate URL
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            completion?(.failure(.requestError(reason: .invalidURL(url: urlString))))
            return
        }
        
        // Image processing options
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 8) // Optional rounding
        let options: KingfisherOptionsInfo = [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(0.3)), // Smooth fade-in transition
            .cacheOriginalImage // Cache the original image for reuse
        ]
        
        // Load image
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options,
            progressBlock: { receivedSize, totalSize in
                print("Loading progress: \(receivedSize)/\(totalSize)")
            }
        ) { result in
            // Hide loader after image loads
            self.kf.indicatorType = .none
            completion?(result)
        }
    }
}
