/*
 *  Vivandro's Swift Language Tutorial.
 *  Copyright (C) 2015 Vivandro. All rights reserved.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/******************************************************************************
 * Classes
 *
 * Pre-requisite: Compound Types' playground.
 *                That playground has much of the introductory information
 *                about classes. It covers everything about properties in
 *                classes. This playground begins talking directly about
 *                class methods, and ignores class properties for the most part.
 ******************************************************************************/

/******************************************************************************
 *
 * Instance Methods :
 *
 * - Unlike functions, the first method param is unnamed by default. This is
 *   based on the assumption that you would define method names that end in
 *   a preposition. e.g. incrementBy(...). In this case calling it
 *   like incrementBy(count: 5) is not much more meaningful than calling it
 *   so: incrementBy(5)
 * - The hidden self property can be used as a reference to the instance.
 * - The var properties of a const reference can be changed.
 ******************************************************************************/
class Counter {
    var count: Int = 0
    let isCounter = true
    var numPrimesUpto5 = { () -> Int in // Can initialize properties using
        // calls to closures and global functions.
        return countElements([2, 3, 5])
        }() // Don't forget to invoke the closure. Notice the () in the end
    
    func incrementBy(amount: Int, numberOfTimes: Int) { // Instance method
        self.count += amount * numberOfTimes
    }
    class func gimmeAString() -> String { // Type/Class method
        return "Here you go"
    }
}

let counter = Counter()                  // Instantiation
counter.incrementBy(5, numberOfTimes: 3) // Method call. 1st param is unnamed.
counter.count = counter.count * 25       // Variable property read/write access
counter.isCounter                        // Const property read access
// counter.isCounter = false             // ERROR: Atempt to modify const property

Counter.gimmeAString()
// counter.gimmeAString() // ERROR: class methods cannot be called on instances

/******************************************************************************
 *
 * Identity versus Equality/Equivalence Operators
 *
 * === vs ==
 * !== vs !=
 *
 * - “Identical to” means that two constants or variables of class type refer
 *   to exactly the same class instance.
 * - “Equal to” means that two instances are considered “equal” or “equivalent”
 *   in value, for some appropriate meaning of “equal”, as defined by the type’s
 *   designer.
 ******************************************************************************/
let counter2 = counter
counter2 === counter
counter2 !== counter

// counter2 == counter
// counter2 != counter

/******************************************************************************
 * Classes - Inheritance
 * No need to inherit from a global base class like NSObject in Objective C
 ******************************************************************************/

/******************************************************************************
 * Subclassing
 * - Subclassing syntax
 * - The super keyword
 * - initializer
 * - Why call super.init() before modifying the inherited properties?
 * - No multiple inheritance...we have interfaces( called protocols in Swift)
 *   for that kind of behavior
 ******************************************************************************/
class Vehicle {
    var numberOfWheels = 4
    var maxPassengers = 1
    
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}


/******************************************************************************
 * Overriding
 ******************************************************************************/
class Car: Vehicle {
    var speed: Double = 0.0
    override init() {
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    override func description() -> String {
        return super.description() + "; "
            + "traveling at \(speed) mph"
    }
    // Two implications of the override keyword.
    // func description() -> String { // ERROR
    // override func nonExistant () -> String {return "Hello"} // ERROR
}



/*
 * Overriding properties:
 * You can override property setters, getters and observers wherever applicable.
 *
 * So where is it not applicable?
 * The obvious? places - No setters for an inherited constant or computed property
 * - No observers for an inherited constant or computed property
 * - If you already have a setter, you cannot override an observer
 */

/*
 * Preventing overrides:
 * Use the @final attribute
 * Override prevention:
 * @final var, @final func
 * Subclassing prevention
 * @final class
 */


/******************************************************************************
 * init/deinit
 * parameter names
 * modifying const properties
 ******************************************************************************/
class Celsius {
    let temperatureInCelsius: Double = 0.0 // Constant property
    init(fahrenheit: Double) {
        // You are allowed to modify conastant properties only during init.
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(_ fahrenheitInteger: Int) {
        temperatureInCelsius = Double(fahrenheitInteger - 32) / 1.8
    }
    
    func tempModifier(fahrenheit: Double) {
        // temperatureInCelsius = (fahrenheit - 32.0) / 1.8 // ERROR
    }
    deinit { // deinit is only available for classes.
        // Release any resources that do not get automatically released by object destruction
    }
}

// let boilingPointOfWater = Celsius(212.0) // ERROR
let boilingPointOfWater = Celsius(fahrenheit: 212.0)
let boilingPointOfWaterIsAlso = Celsius(212)

/******************************************************************************
 * Initializer delegation
 * Why?
 * How?
 ******************************************************************************/
class A1Base {
    var baseVal: Int
    
    init() {
        baseVal = 10
    }
    init(val: Int) {
        //self.init()   // ERROR: Cannot delegate to other intializers of the same
        //        class from designated init
        baseVal = val
    }
    init(val: String){
        baseVal = countElements(val)
    }
    convenience init(foo: () -> Int) {
        // baseVal = foo() // ERROR: cannot set properties before calling designated init
        // init() // ERROR: init can never be called directly like other methods.
        self.init()     // Phase 1 of initialization
        //self.init()   // Cannot call init multiple times
        baseVal = foo() // Phase 2 of initializaion
    }
}


/******************************************************************************
 * Initializer and inheritance
 * Show the image with the rules of initializer call order
 *
 * - Convenience initializers can only call other initializers from the same class
 * - Only designated initializers from the super can be invoked from the sibclass.
 ******************************************************************************/

class B1Derived : A1Base {
    override init() {
        super.init()
        baseVal = 10
    }
    override init(val: Int) { // Use override qualifier when overriding designated initializers.
        // baseVal = 100 // ERROR cannot set properties before calling the super init.
        //super.init(foo: {20}) // ERROR: cannot call convenience initializers from the super class.
        super.init()
        //super.init(val: 90) // ERROR: cannot call multiple super init.
        //super.init() // ERROR: cannot call the same super init multiple times.
    }
    convenience init(foo: () -> Int) {  // Should NOT use override for init's matching
        // signatures of convenience init from super.
        self.init(val: foo())
    }
}

var a1Var = A1Base(val: "Hello")
// var b1Var = B1Derived(val: "Hello") // ERROR: initializers are not automatically inherited.
/*
 * Automatic Initializer Inheritance
 *
 * Superclass initializers are only inherited if it is safe to do so:
 * - If the subclass does not define any designated initializers, it inherits
 *   all designated initializers from the superclass
 * - If the subclass provides an implementation of all the designated initializers
 *   from the super class, either explicitly or by the above rule, it inherits
 *   all the convenience initializers. This works even when subclass defined
 *   other convenience initializers.
 */

/*
 * Failable Initializers: This is a topic worth checking out. The most direct impact
 * it has is on enumerations with raw values of the format:-
 * init?(rawValue:)
 * If the rawValue does not fit any of the enumeration cases, then it does not
 * make sense to keep the object alive, and hence you get back nil.
 * Classes and structs are also allowed to have such failable initializers.
 */

/*
 * Required Initializers:
 * - Syntax:
 *   required init() {
 *       ...
 *   }
 * - This forces all the subclasses to override this initializer.
 * - Subclasses MUST use required qualifier as well and thus propogate
 *   the requirement through the heirarchy.
 * - Since required qualifier already indicates that the initializer needs
 *   to be overridden, we should not use the override qualifier explicitly when
 *   we override the required initializers in the subclasses. (Personally, I
 *   think this reduces the safety provided by the override keyword. For
 *   ex., if I add 'required init(val: String)' in a subclass, does if mean
 *   I am providing the implementation of a required nitializer or does it mean
 *   that I am introducing a new required initializer that my super class
 *   never asked for, but my subclasses will have to implement?)
 */

/******************************************************************************
 * Deinitializer and inheritance
 * Inherited and called at the end of subclass deinit regardless of whether or
 * not a subclass has a deinint(meaning there might be an empty deinit added by
 * the compiler in such cases)
 *
 * Syntax:
 * deinit {
 *     ...
 * }
 ******************************************************************************/


/******************************************************************************
 * Typecasting
 * Typecasting in Swift is implemented via two keywords in 3 forms: 'is' 'as' 'as?'
 * It is aided/simplified by binding via switch-case.
 ******************************************************************************/

class ABase {
    
}

class BDerived : ABase {
    
}

class CDerived: ABase {
    
}

// The type for aCollection is inferred as [ABase]
let aCollection = [BDerived(), ABase(), BDerived(), CDerived(), BDerived()]

// Type checking vis the is operator
func printCollectionTypes(aCollection: [ABase]) -> [String] {
    var result = [String]()
    
    for item in aCollection {
        if item is BDerived { // is performs a check that returns true/false
            result.append("-BDerived")
        } else if item is CDerived {
            result.append("-CDerived")
            //} else if item is ABase {   // ERROR: is test is always true, because that is
            // the type of the objects in the aCollection array
        } else {
            result.append("-ABase")
        }
    }
    
    return result
}
printCollectionTypes(aCollection)

// Type checking via the optional downcasting operator as?
func printCollectionTypes2(aCollection: [ABase]) -> [String] {
    var result = [String]()
    
    for item in aCollection {
        if let itemB = item as? BDerived {
            result.append("+BDerived")
        } else if let itemC = item as? CDerived {
            result.append("+CDerived")
            //} else if let itemA = item as? ABase {   // ERROR: Conditional downcast from
            // ABase to ABase always succeeds
        } else {
            result.append("+ABase")
        }
    }
    
    return result
}
printCollectionTypes2(aCollection)

// Simplified type matching via switch-case and the forced cast operator 'as'
func printCollectionTypes3(aCollection: [ABase]) -> [String] {
    var result = [String]()
    
    for item in aCollection {
        switch item {
        case let itemB as BDerived:
            result.append("=BDerived")
        case let itemC as CDerived:
            result.append("=CDerived")
            //case let itemA as ABase:// ERROR: is test is always true. So that's what switch
            //    result.append("ABase") // uses internally to match the cases.
        default:
            result.append("=ABase")
        }
    }
    
    return result
}
printCollectionTypes3(aCollection)



/******************************************************************************
 * Typealiases for non-specific types
 * AnyObject : Represents an instance of any 'class' type
 * Any       : Represents an instance of any type at all - class, enum, struct, function
 *
 * When working with Cocoa APIs it is common to receive an array with type
 * [AnyObject] because Objective C does not have explicitly typed arrays/collections.
 *
 ******************************************************************************/

var things = [Any]()
things.append(24)
things.append(12)
things.append(42)
things.append(3.14)
things.append("Hello")
things.append(ABase())

func printThings(aCollection: [Any]) -> [String] {
    var result = [String]()
    
    for item in aCollection {
        switch item {
        case let i as BDerived:
            result.append("~BDerived")
        case let i as CDerived:
            result.append("~CDerived")
        case let i as ABase:
            result.append("~ABase")
        case 0 as Int:
            result.append("~0 Int")
        case 42 as Int: // We can use as to match specific values as well
            result.append("~42 Int")
        case let i as Int where i == 12: // We can match pattern usin where clause as well
            result.append("~Int is 12")
        case let _ as Int: // We can ignore the matched value
            result.append("~Int")
        case let i as Double:
            result.append("~Double")
        default:
            result.append("~Unknown")
        }
    }
    
    return result
}

printThings(things)

