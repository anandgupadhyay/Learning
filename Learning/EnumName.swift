
@objc enum Fruit1: Int {
}//This is correct 

@objc enum City: String {
}//This will give Error 

//@obj can be used with Int type enum but can not be used with String or any other type cause in Objective C Enum can be only of Int type
//The same way @objc will not work with any indepenant function it will work with only function inside Classes.


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
