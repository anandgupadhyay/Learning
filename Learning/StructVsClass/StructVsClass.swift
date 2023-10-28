//
//  StructVsClass.swift
//  Learning
//
//  Created by Anand Upadhyay on 28/10/23.
//

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

var companyClass = Company1(employees: [])
for _ in 1...100000 {
    let employee = EmployeeClass1(name: "John Doe", age: 30)
    companyClass.addEmployee(employee: employee)
}

var companyStruct = Company1(employees: [])
for _ in 1...100000 {
    var employee = EmployeeStruct(name: "John Doe", age: 30)
    employee.celebrateBirthday()
    companyStruct.employees.append(employee)
}
