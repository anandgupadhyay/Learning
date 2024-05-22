func jpegImage(image: UIImage, maxSize: Int, minSize: Int, times: Int) -> Data? {
    var maxQuality: CGFloat = 1.0
    var minQuality: CGFloat = 0.0
    var bestData: Data?
    for _ in 1...times {
        let thisQuality = (maxQuality + minQuality) / 2
        guard let data = UIImageJPEGRepresentation(image, thisQuality) else { return nil }
        let thisSize = data.count
        if thisSize > maxSize {
            maxQuality = thisQuality
        } else {
            minQuality = thisQuality
            bestData = data
            if thisSize > minSize {
                return bestData
            }
        }
    }

    return bestData
}


//How to use

jpegImage(image: image, maxSize: 500000, minSize: 400000, times: 10)
