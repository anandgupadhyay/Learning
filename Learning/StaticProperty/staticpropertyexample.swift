//
//  staticpropertyexample.swift
//  Learning
//
//  Created by Anand Upadhyay on 08/02/24.
//

import Foundation
Let's delve into a detailed example of static variables and their usage, alongside a real-life scenario involving lazy variables in the context of an employee company case.

Static Variables:

Static variables in Swift belong to the type itself rather than to instances of that type. They're shared across all instances of the type and are typically used to store values or configurations that are common to all instances. While they're static in nature, they can still be mutable (hence the 'var' keyword).

Example - Static Variable:

Consider a class Employee representing employees in a company. Each employee has a unique employee ID, but the company might want to keep track of the total number of employees across all instances of the Employee class.



class Employee {
    var name: String
    var employeeID: Int
    static var totalEmployees: Int = 0 // Static variable to keep track of total employees
    
    init(name: String) {
        self.name = name
        self.employeeID = Employee.totalEmployees // Assign unique employee ID
        Employee.totalEmployees += 1 // Increment total employees
    }
}

// Example usage
let emp1 = Employee(name: "John")
let emp2 = Employee(name: "Jane")
print(Employee.totalEmployees) // Output: 2




In this example, totalEmployees is a static variable of the Employee class. It keeps track of the total number of employees created, regardless of how many instances of Employee are initialized.

Lazy Variables:

Lazy variables are properties whose initial values are not calculated until the first time they are accessed. They're particularly useful for delaying the initialization of properties until they're actually needed. This can be beneficial for optimizing memory usage and improving performance, especially when dealing with expensive computations or resources.

Real-life Scenario - Lazy Variable:

Consider a scenario where the company maintains a directory of employee profiles, including their contact information, job title, and department. Loading employee profiles from a database can be resource-intensive, especially if the directory is large. Here, lazy loading can help improve performance by deferring the loading of employee profiles until they're requested.


class EmployeeDirectory {
    lazy var employeeProfiles: [EmployeeProfile] = self.loadEmployeeProfiles()
    
    func loadEmployeeProfiles() -> [EmployeeProfile] {
        // Simulated heavy operation to load employee profiles from database
        print("Loading employee profiles from database...")
        // Assume loading from a database and returning employee profiles
        return [/ List of employee profiles /]
    }
}

struct EmployeeProfile {
    var name: String
    var jobTitle: String
    var department: String
    // Additional properties...
}

// Example usage
let directory = EmployeeDirectory()
// Employee profiles are not loaded yet
print("Accessing employee profiles...")
let profiles = directory.employeeProfiles // Lazy loading triggered here



In this scenario, employeeProfiles is a lazy variable of the EmployeeDirectory class. The loadEmployeeProfiles() method is only executed the first time employeeProfiles is accessed. Subsequent accesses retrieve the previously loaded profiles without reloading them from the database.

This approach optimizes memory usage and startup time, as employee profiles are only loaded when needed, rather than upfront during initialization.

By combining static and lazy variables, you can effectively manage shared resources and optimize performance in your Swift applications.

