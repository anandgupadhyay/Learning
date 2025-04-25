enum Fruit: Int {
    case Orange = 1
    case Apple = 2
}

if let fruit = Fruit(rawValue: 1) {
    let caseName = "\(fruit)"  // This will be "Orange"
    print(caseName)
}

