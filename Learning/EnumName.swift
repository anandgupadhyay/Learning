enum Fruit: Int {
    case Orange = 1
    case Apple = 2
}

if let fruit = Fruit(rawValue: 1) {
    let caseName = "\(fruit)"  // This will be "Orange"
    print(caseName)
}

//Another way
enum MyEnum {
    case firstCase
    case secondCase
    
    var name: String {
        switch self {
        case .firstCase: return "firstCase"
        case .secondCase: return "secondCase"
        }
    }
}
