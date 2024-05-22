extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }

    func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 1.0) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
}


// func jpegImage(image: UIImage, maxSize: Int, minSize: Int, times: Int) -> Data? {
//     var maxQuality: CGFloat = 1.0
//     var minQuality: CGFloat = 0.0
//     var bestData: Data?
//     for _ in 1...times {
//         let thisQuality = (maxQuality + minQuality) / 2
//         guard let data = UIImageJPEGRepresentation(image, thisQuality) else { return nil }
//         let thisSize = data.count
//         if thisSize > maxSize {
//             maxQuality = thisQuality
//         } else {
//             minQuality = thisQuality
//             bestData = data
//             if thisSize > minSize {
//                 return bestData
//             }
//         }
//     }

//     return bestData
// }


// //How to use

// jpegImage(image: image, maxSize: 500000, minSize: 400000, times: 10)
