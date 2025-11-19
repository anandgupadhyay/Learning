//
//  ErrorHandlingInSwiftWithExample.swift
//  Learning
//
//  Created by Anand Upadhyay on 28/10/23.
//

import Foundation
// Define an Employee struct with properties
struct Employee {
    let id: Int
    let name: String
    let jobTitle: String
    let salary: Double
    var targetsMet: Bool
}

// Define custom errors related to employees
enum EmployeeError: Error {
    case employeeNotFound
    case targetsNotMet
}

// Create a Company class to manage employees
class Company {
    var employees: [Employee]
    
    init(employees: [Employee]) {
        self.employees = employees
    }
    
    // Find an employee by ID
    func findEmployee(byID employeeID: Int) throws -> Employee {
        guard let employee = employees.first(where: { $0.id == employeeID }) else {
            throw EmployeeError.employeeNotFound
        }
        return employee
    }
    
    // Calculate an employee's bonus
    func calculateBonus(for employeeID: Int) throws -> Double {
        let employee = try findEmployee(byID: employeeID)
        guard employee.targetsMet else {
            throw EmployeeError.targetsNotMet
        }
        // Calculate the bonus based on certain criteria
        let bonus = employee.salary * 0.10
        return bonus
    }
}

// Sample usage
let employees = [
    Employee(id: 1, name: "Mac", jobTitle: "Developer", salary: 60000, targetsMet: true),
    Employee(id: 2, name: "Shabeer", jobTitle: "Designer", salary: 55000, targetsMet: false),
    Employee(id: 3, name: "Ghandol", jobTitle: "Manager", salary: 75000, targetsMet: true)
]

let company = Company(employees: employees)

class demo{
    
    func testing(){
        do {
            let bonus = try company.calculateBonus(for: 1)
            print("Alice's bonus: $\(bonus)")
        } catch EmployeeError.employeeNotFound {
            print("Employee not found.")
        } catch EmployeeError.targetsNotMet {
            print("Employee didn't meet targets.")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
}


//rethrow use with example
enum OperationError: Error {
    case failed
}

func logOperation(_ operation: () throws -> Void) rethrows {
    print("Starting operation...")
    try operation() // Calls the throwing closure parameter
    print("Operation finished.")
}

//Using with a non-throwing closure:
//No try is required because the closure doesn't throw. 

let nonThrowingOperation = {
    print("Performing safe work")
}

logOperation(nonThrowingOperation) // Works fine, no try needed

