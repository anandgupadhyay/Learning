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
