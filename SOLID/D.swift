/* The Dependency Inversion Principle (DIP) states two key things:
High-level modules (business logic) should not depend on low-level modules (implementation details like databases, 
network clients, or disk storage).
Both should depend on abstractions (protocols in Swift).
Abstractions should not depend on details; details should depend on abstractions.
*/


import Foundation

// ============================================================================
// MARK: - ❌ VIOLATION OF DIP (Tight Coupling)
// ============================================================================

// Low-level module: Tightly coupled to MySQL
final class MySQLDatabase {
    func saveUser(name: String) {
        print("[MySQL] Saving user '\(name)' to MySQL database...")
    }
}

// High-level module: Directly instantiates and depends on MySQLDatabase
final class UserServiceBad {
    // Tightly coupled dependency
    private let database = MySQLDatabase()
    
    func registerUser(name: String) {
        // Business logic bound directly to MySQL
        print("[UserServiceBad] Registering user...")
        database.saveUser(name: name)
    }
}

// Usage showing the issue:
// If you want to switch to PostgreSQL or mock this for unit tests, 
// you have to rewrite UserServiceBad completely.


// ============================================================================
// MARK: - ✅ ADHERING TO DIP (Loose Coupling via Abstraction)
// ============================================================================

// STEP 1: Define an Abstraction (Protocol)
// The high-level module defines what it needs from a database layer.
protocol DatabaseStorage {
    func save(data: String)
}

// STEP 2: Low-Level Modules implement the Abstraction

final class MySQLStorage: DatabaseStorage {
    func save(data: String) {
        print("[MySQLStorage] Saving '\(data)' into MySQL database...")
    }
}

final class PostgresStorage: DatabaseStorage {
    func save(data: String) {
        print("[PostgresStorage] Saving '\(data)' into PostgreSQL database...")
    }
}

final class MockDatabaseStorage: DatabaseStorage {
    var savedData: [String] = []
    
    func save(data: String) {
        savedData.append(data)
        print("[MockStorage] Saved '\(data)' in memory for testing.")
    }
}

// STEP 3: High-Level Module depends ONLY on the Abstraction
final class UserService {
    // Injected abstraction dependency
    private let database: DatabaseStorage
    
    // Initializer Dependency Injection
    init(database: DatabaseStorage) {
        self.database = database
    }
    
    func registerUser(name: String) {
        print("[UserService] Registering user process started...")
        database.save(data: name)
    }
}


// ============================================================================
// MARK: - 🚀 RUNTIME EXECUTION
// ============================================================================

print("--- 1. Using MySQL Storage ---")
let mysqlDB = MySQLStorage()
let userServiceWithMySQL = UserService(database: mysqlDB)
userServiceWithMySQL.registerUser(name: "Alice")

print("\n--- 2. Switching to PostgreSQL (Zero changes to UserService) ---")
let postgresDB = PostgresStorage()
let userServiceWithPostgres = UserService(database: postgresDB)
userServiceWithPostgres.registerUser(name: "Bob")

print("\n--- 3. Unit Testing with a Mock Storage ---")
let mockDB = MockDatabaseStorage()
let userServiceForTest = UserService(database: mockDB)
userServiceForTest.registerUser(name: "Charlie")

print("Mock stored count: \(mockDB.savedData.count)") // Verification for unit testing
