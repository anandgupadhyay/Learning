//
//  StructVsClass.swift
//  Learning
//
//  Created by Anand Upadhyay on 28/10/23.
//

// simplify working with value types in arrays you could use following extension (Swift 3):

//Struct and Class


class Address {
    var city: String

    init(city: String) {
        self.city = city
    }
}

struct Person {
    var name: String
    var address: Address
}

var person1 = Person(name: "AT", address: Address(city: "Delhi"))
var person2 = person1 // person2 now references the same address as person1

person2.address.city = "Mumbai"

extension Array {
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }

    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
        var element = self[index]
        modifyElement(&element)
        self[index] = element
    }
}



//testings.modifyElement(atIndex: 0) { $0.value = 99 }
//testings.modifyForEach { $1.value *= 2 }
//testings.modifyForEach { $1.value = $0 }


import Foundation
class EmployeeClass1 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func celebrateBirthday() {
        age += 1
    }
}

struct EmployeeStruct {
    var name: String
    var age: Int
    
    mutating func celebrateBirthday() {
        age += 1
    }
}

class Company1 {
    var employees: [EmployeeClass1]
    
    init(employees: [EmployeeClass1]) {
        self.employees = employees
        
    }
    
    func addEmployee(employee: EmployeeClass1) {
        employees.append(employee)
    }
}


//var companyClass = Company1(employees: [])
//for _ in 1...100000 {
//    let employee = EmployeeClass1(name: "John Doe", age: 30)
//    companyClass.addEmployee(employee: employee)
//}
//
//var companyStruct = Company1(employees: [])
//for _ in 1...100000 {
//    var employee = EmployeeStruct(name: "John Doe", age: 30)
//    employee.celebrateBirthday()
//    companyStruct.employees.append(employee)
//}


class someclass{
    
    init(){
        var counter = Counter()
//        Task.detached{
            print(counter.increment())
//        }
    }
}

struct Counter{
    var Value = 0
    mutating func increment() -> Int{
     Value = Value + 1
        return Value
    }
}

