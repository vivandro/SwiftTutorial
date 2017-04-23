//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

// Basics
protocol AllTheThings {
    // instance properties. These can only be declared as var.
    // let gettableOneLet: Int // ERROR: Immutable properties must be declared as var with get
    // let gettableTwoLet: Int {get} // ERROR: let declarations cannot be coputed properties
    var gettableOne: Int {get} //
    var gettableTwo: Int {get}
    var settableOne: Int {get set} // no commas between get and set

    // instance methods
    func saySomething()
    // mutating method
    mutating func mutateSomething()
    
    
    // type properties
    // Use static to indicate type properties. When adopting this protocol in
    // a class, you would use the keyword class instead of static. But in the protocol
    // specification, we can only use static.
    static var gettableOneStatic: Int {get}
    
    // type methods
    static func typeMethod()
}


/*
gettableOne ... simple getter
gettableTwo, getter as well as setter

for mutating method, a class adopting it should not use the mutating keyword. Enums and Struct should use it though.

 adoption using extensions/ empty extensions.

*/

// Protocol Adoption
class Something {
    var gettableOne: Int {return 1} // get requirement can be satisfied with a read-only property
    var gettableTwo: Int = 2 // get requirement can be satisfied with a read-write property
    var settableOne: Int = 11
    func saySomething() {}
    func mutateSomething() {gettableTwo += 1}
    static var gettableOneStatic: Int {return 10}
    static func typeMethod() {}
}

// If the class already implements all the protcol requirements, it is enough to just specify the 
// protocol conformance in an extension.
extension Something: AllTheThings {}
// extension Something: AllTheThings {} // ERROR: redundant conformance to protocol 'AllTheThings'

// Initializer requirements
// Protocols can specify specific initializer signatures required by adopting types.
protocol SpecialInit {
    init(magicWord: String)
}

// The required keyword is required in a class adoption, but not in a struct.
// Error is: Initializer requirement init(magicWord) can only be satisfied by a 'required' initializer in non-final
// class 'Sucker'.
// This means that we are forcing all subclasses to provide this initializer as well. This means it's not required
// on final classes.
// TODO: So, why isn't this a requirement for structs as well?
class Sucker: SpecialInit {
     required init(magicWord: String) {
        print("The magic word is : \(magicWord)")
    }
}
struct IntTwo : SpecialInit {
    init(magicWord: String) {
        print("The magic word is : \(magicWord)")
    }
}


// Protocol Inheritance - Stratightforward.
protocol MoreThings : AllTheThings {
    var oneMoreInt: Int {get}
}


// Class-only protocols.
// use the class keyword to inherit from. Weird syntax. Also, it has to be the first word in the
// inheritance list.

protocol ClassOnly : class { }
protocol ClassOnlyThings : class, AllTheThings { }

// Protocol conformance requirement
// Single protocol requirement can be specified byt using the protocol name in place
// of a type
func processAllTheThings(_ things: AllTheThings) {}

// Multiple protocol conformance requirement. This is specified using what is called 
// protocol composition. protocol<Abc, Def>
// I would rather go for a new protocol that derives frmo all the composed protocols rather than 
// use the composition on its own.
// protocol AbcDef : Abc, Def {}
// ERROR: protocol 'Hashable' can only be used as a generic constraint because it has Self or associated type requirements
//func processAllTheThingsAndHashable(things: protocol<AllTheThings, Hashable>) {} // TODO: why?
protocol AndMore {}
func processAllTheThingsAndMore(_ things: AllTheThings & AndMore) {}

protocol AllHash: AllTheThings, Hashable {}
// And that still doesn't solve the problem I was facing above.
// ERROR: protocol 'AllHash' can only be used as a generic constraint because it has Self or associated type requirements
//func processAllHash(things: AllHash) {}


/*
1. @objc
2. Optional Requirements
Optional requirements can only be specified for protocols marked @objc.
Protocols marked @objc can only be adopted by classes inheriting eventually from NSObject or classes marked @objc.
This also means they cannot be adopted by structs and enums.

Use optional chaining to invoke such methods on instances of conforming classes.
*/

@objc protocol Summable {
    @objc optional func add(_ a: Int, b: Int) -> Int
}

class UseSummable {
    var summable: Summable?
    func blah() -> Int? {
        // Use optional chaining to invoke the add method.
        return summable?.add?(1, b: 2)
    }
}

class SummableA: Summable {
//    @objc func add(a: Int, b: Int) -> Int {
//        return 2
//    }
}

let a: SummableA? = SummableA()

// Because we know everything that is relevant about this type, the following line will
// be flagged as a compiler error and ensure that we can never call th add method on a in any way.
//a?.add?(1, b: 2) //ERROR: SummableA does not implement method add

// Since b's concrete type is not known, we are allowed to use optional chaining to call the add method.
let b: Summable = SummableA()
b.add?(1, b: 2)


// Protocol Extensions and Default Implementations
// Use protocol extensions to provide property and method implementations.
// Types can provide their own implementations that will replace the default implementations.
// “If a conforming type satisfies the requirements for multiple constrained extensions that 
//  provide implementations for the same method or property, Swift will use the implementation
//  corresponding to the most specialized constraints.”

extension Summable {
    func add(_ a: Int, b: Int) -> Int {
        return a + b
    }

    // You can even add new methods to a protocol via the extension.
    func newFun() -> Int {return  3}
}

let t = SummableA()
t.newFun()

// Adding constraints to protocol extensions - This can only be done for generic protocols.
// Check out the playground on generics for this part.

