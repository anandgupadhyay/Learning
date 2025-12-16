/*
What is Never in Swift?

Never is a special type that means:

“This code path can never happen.”

A function returning Never:

Never returns normally

Always crashes, exits, or loops forever

A generic using Never:

Indicates impossibility (e.g. a Result that cannot fail or cannot succeed)
*/

func enableDebugMode() -> Never {
    // Save debug flag permanently
    UserDefaults.standard.set(true, forKey: "isDebugModeEnabled")

    // Exit the app immediately
    exit(0)
}

func alwaysCrash() -> Never {
    fatalError("This function always crashes")
}

func runForever() -> Never {
    while true {
        // Simulate background work
        Thread.sleep(forTimeInterval: 0.1)
    }
}


func testNeverFailure() {
    // Failure is impossible
    let result: Result<String, Never> = .success("Safe value")

    switch result {
    case .success(let value):
        print(value)

    // No `.failure` case needed!
    // The compiler knows failure cannot exist
    }
}
//Result<Success, Never> means guaranteed success
//The compiler removes unreachable branches


enum RequestError: Error {
    case bad
}

struct AlwaysFailingRequest {
    func send(completion: @escaping (Result<Never, Error>) -> Void) {
        // Success is impossible
        completion(.failure(RequestError.bad))
    }
}

//Result<Never, Error> means guaranteed failure
//Never proves success cannot occur
