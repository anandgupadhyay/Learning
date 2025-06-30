//Optimisaing Performance
//Loading Images fastewr
//Creating Thumbnail
import UIKit

func createThumbnail(from image: UIImage, size: CGSize) -> UIImage? {
    return image.preparingThumbnail(of: size)
}

// Example usage
if let image = UIImage(named: "largeImage"),
   let thumbnail = createThumbnail(from: image, size: CGSize(width: 100, height: 100)) {
    // Use the thumbnail image
    // e.g., display it in a UIImageView
}
