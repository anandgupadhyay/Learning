protocol SomeProtocol {
 func doSomething ()
}

extension SomeProtocol {
 func doSomething () {
 print( "SomeProtocol")
 }
}

class BaseClass: SomeProtocol {}

class SubClass: BaseClass {
 func doSomething () {
 print("SubClass")
 }
}

class AnotherClass: SomeProtocol {
 func doSomething() {
 print( "AnotherClass")
 }
}
