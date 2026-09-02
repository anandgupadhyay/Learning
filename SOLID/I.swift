//The Interface Segregation Principle (ISP) states that no client should be forced to depend on methods it does not use.
//Instead of creating large, monolithic interfaces ("fat" protocols in Swift), 
//it is better to break them into smaller, highly targeted protocols so that conforming types only implement what they actually need.



import Foundation

// MARK: - ❌ VIOLATION (Fat Interface)
// A monolithic protocol that forces all clients to implement methods they might not need.

protocol BadWorker {
    func work()
    func eat()
    func sleep()
}

struct BadHumanWorker: BadWorker {
    func work() { print("Human working...") }
    func eat() { print("Human eating lunch...") }
    func sleep() { print("Human sleeping...") }
}

struct BadRobotWorker: BadWorker {
    func work() { print("Robot working...") }
    
    // Forced implementations for actions a robot cannot perform
    func eat() { fatalError("Robots don't eat!") }
    func sleep() { fatalError("Robots don't sleep!") }
}


// MARK: - ✅ ADHERENCE (Interface Segregation Principle)
// Segregated, single-responsibility protocols.

protocol Workable {
    func work()
}

protocol Feedable {
    func eat()
}

protocol Restable {
    func sleep()
}

// Human workers require work, food, and rest.
// We can use Swift's protocol composition to combine them cleanly.
typealias HumanoidRequirements = Workable & Feedable & Restable

struct HumanWorker: HumanoidRequirements {
    func work() { print("Human working diligently.") }
    func eat() { print("Human taking a lunch break.") }
    func sleep() { print("Human resting overnight.") }
}

// Robot workers only need work functionality.
struct RobotWorker: Workable {
    func work() { print("Robot processing jobs 24/7.") }
}

// MARK: - Client Usage

final class Manager {
    // Only depends on the exact behavior it needs to invoke
    func startShift(worker: Workable) {
        worker.work()
    }
    
    func manageLunchBreak(worker: Feedable) {
        worker.eat()
    }
}

// Execution
let manager = Manager()

let human = HumanWorker()
let robot = RobotWorker()

manager.startShift(worker: human)       // Human working diligently.
manager.startShift(worker: robot)       // Robot processing jobs 24/7.

manager.manageLunchBreak(worker: human) // Human taking a lunch break.
// manager.manageLunchBreak(worker: robot) 
// 🔴 Compiler Error: RobotWorker does not conform to Feedable (Prevents runtime bugs!)
