//Write a function to calculate sum of 0 to 5000000 in an memory and time efficient manner
func addNumbersUsingDispatchQueue(range: ClosedRange<Int> = 0...500_000, completion: @escaping (Int) -> Void) {
    let queue = DispatchQueue(label: "com.andrew.smartaddition", attributes: .concurrent)
    let group = DispatchGroup()
    let chunkSize = 100000
    var totalSum = 0

    // Split the range into smaller chunks for concurrent processing
    for start in stride(from: range.lowerBound, to: range.upperBound, by: chunkSize) {
        let end = min(start + chunkSize - 1, range.upperBound)
        group.enter()

        queue.async {
            let chunkSum = (start...end).reduce(0, +)
            totalSum += chunkSum
            group.leave()
        }
    }

    // Notify completion once all tasks are done
    group.notify(queue: .main) {
        completion(totalSum)
    }
}

// Usage
addNumbersUsingDispatchQueue { result in
    print("The total sum is: \(result)")
}

//serial queue
        let serialQ = DispatchQueue(label: "com.gcddemo.serialQ")
        serialQ.async {
            for i in 0..<5{
                debugPrint("Index:\(i)")
            }
        }
        
        //concurrent queue
        let concurrentQ = DispatchQueue(label: "com.gcddemo.serialQ",attributes: .concurrent)
        concurrentQ.async {
            for i in 0..<5{
                debugPrint("Index:\(i)")
            }
        }
        
        //performing task in background
        DispatchQueue.global(qos: .background).async {
            //do some backgroud code like fetch data from server or process business logic
            DispatchQueue.main.async {
                //update UI
                //this step is required to bring the exucution back to main thread
            }
        }
        
        //to delay execution of certain task
        let delay = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: delay){
          debugPrint("Delayed for 2 sec.")
        }
