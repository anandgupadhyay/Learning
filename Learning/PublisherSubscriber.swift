import Foundation
import Combine

class CombineExample{
    
    let myPublisher = PassthroughSubject<String, Never>()
    
    func test1(){
        let mySubscriber = myPublisher.sink(
            receiveCompletion: { completion in
                switch
                completion {
                case .finished:
                    print("Completed")
                case .failure(let error):
                    print("Failed with error: \(error)")
                }
            },
            receiveValue: { value in
                print("Received value: \(value)")
            }
        )
    }
            
    func test2(){
        myPublisher.send("Hello")
        myPublisher.send("World")
        myPublisher.send(completion: .finished)
    }
}
