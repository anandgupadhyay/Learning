let serialQ = DispatchQueue(label: "com.gcddemo.serialQ")
        serialQ.async {
            for i in 0..<5{
                debugPrint("Index:\(i)")
            }
        }


let concurrentQ = DispatchQueue(label: "com.gcddemo.serialQ",attributes: .concurrent)
        serialQ.async {
            for i in 0..<5{
                debugPrint("Index:\(i)")
            }
        }
