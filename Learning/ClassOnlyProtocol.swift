//defines a "class-only protocol": Only class types (and not structures or enumerations) can adopt this protocol.

//Weak references are only defined for reference types. Classes are reference types, structures and enumerations are value types. (Closures are reference types as well, but closures cannot adopt a protocol, so they are irrelevant in this context.)

//Therefore, if the object conforming to the protocol needs to be stored in a weak property then the protocol must be a class-only protocol.

//Here is another example which requires a class-only protocol:

protocol A {
    var name : String { get set }
}

func foo(a : A) {
    a.name = "bar" // error: cannot assign to property: 'a' is a 'let' constant
}
//This does not compile because for instances of structures and enumerations, a.name = "bar" is a mutation of a. If you define the protocol as

protocol A : class {
    var name : String { get set }
}
//then the compiler knows that a is an instance of a class type to that a is a reference to the object storage, and a.name = "bar" modifies the referenced object, but not a.

//So generally, you would define a class-only protocol if you need the types adopting the protocol to be reference types and not value types.
