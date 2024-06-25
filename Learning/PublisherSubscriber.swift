import Combine
let myPublisher = PassthoughSubject<String, Never>O
let mySubscriber = myPublisher.sink(
receiveCompletion: { completion in
switch
completion {
case
•finished:
print("Completed")
case .failure(let error):
print("Failed with error: \(error)")
}
}.
}
receiveValue: { value in
print("Received value: \(value)")
myPublisher. send("Hello")
myPublisher.send("World")
myPublisher.send(completion: finished)
