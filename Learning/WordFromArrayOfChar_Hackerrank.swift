import UIKit


//@objc protocol Drivable{
//    
//    @objc optional func drive()
//}

//class A{
//    
//}

struct vehicle{
    var number: String = ""
}

struct car{
    var wheel:Int
}

var honda1 = vehicle(number: "GJO1")
print(honda1)
honda1.number = "GJ04"
print(honda1)



let honda2 = vehicle(number: "RJ45")
print(honda2)

var array = [honda1,honda2]

array[0].number = "BR01"
print(array[0])
print(honda1)


var greeting = "Hello, playground"
let charArray1 = ["a", "n", "a", "n", "d"]
//
//
var histogram = charArray1.reduce(into: [:]) { count, id in
    return count[id,default: 0]+=1
}
print(histogram)


func canFormName(using charArray: [String], _ name: String) -> Bool {
    // Create a dictionary to store the count of characters in charArray
    var charCount = [String: Int]()
    
    // Count occurrences of characters in charArray
    for char in charArray {
        charCount[char, default: 0] += 1
    }
    
    print(charCount)
    
    // Check if name can be formed using characters in charArray
    for char in name {
        // If the character doesn't exist in charArray or its count is 0, return false
        let charString = String(char)
        guard let count = charCount[charString], count > 0 else {
            return false
        }
        // Decrease the count of the character
        charCount[charString]! -= 1
    }
    
    // If all characters in name have been matched with charArray, return true
    return true
}

let charArray = ["a","n","a", "n", "a", "n", "d"]
let name = "fanand"

if canFormName(using: charArray, name) {
    print("The name '\(name)' can be formed using the characters in charArray.")
} else {
    print("The name '\(name)' cannot be formed using the characters in charArray.")
}

