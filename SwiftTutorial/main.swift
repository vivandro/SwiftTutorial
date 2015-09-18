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

println("Hello, World!")


/*********************************
ARC - Automatic Reference Counting

Fairly straight-forward. Just need to understand the following concepts:
- Variables referring reference objects result in increment of the reference count of an object. Referring to some other object, decrements the reference count of the previously referred object and increments that for the new object.
- Keywords to understand:
strong
weak
unowned
- Variables, properties and closures capture objects stringly without requiring us to use the strong keyword
- To break reference cycles, use
weak : if the model implies no independent ownership
e.x.,
class Apartment {
weak var tenant: Person?
}
unowned : if the model implies ownership, but no dependency w.r.t. lifetime.
e.x., a credit card needs an owner, but should not dictate the lifetime of the owner
class CreditCard {
unowned let customer:Customer
}

*********************************/

var personCount = 0
var apartmentCount = 0
class Person {
    let name: String
    init(_ name: String) {
        self.name = name
        ++personCount
    }
    weak var apartment: Apartment?
    deinit {
        --personCount
    }
}

class Apartment {
    let number: Int
    init(_ number: Int) {
        self.number = number
        ++apartmentCount
    }
    weak var tenant: Person? // Remove the weak qualifier if you want demo of ref-cycle.
    deinit {
        --apartmentCount
    }
}

println(personCount)
println(apartmentCount)

// Why use optionals here?
var john: Person? = Person("John Appleseed")
var number73: Apartment? = Apartment(73)

println(personCount)
println(apartmentCount)

john?.apartment = number73
number73?.tenant = john

john = nil
number73 = nil

println(personCount)
println(apartmentCount)

// Proof that ARC works perfectly and playground is buggy.
// The bug seems to be that playground doesn't call deinit when ARC releases the object.
var joe:Person? = Person("Joe")
println(personCount)
joe = nil
println(personCount)


/*
Make one of these weak in order to break the retain cycle
weak var apartment: Apartment?
weak var tenant: Person?

Only one of these needs needs to be weak to break the cycle. But it makes
logical sense to make both of these weak.

To see the reference cycle, ensure that neither is qualified as a weak. reference

*/

/******************************************************************************
 * unowned references to break the retain cycle
 ******************************************************************************/
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var jane: Customer? = Customer(name: "Jane Appleseed")
jane?.card = CreditCard(number: 1234_5678_9012_3456, customer: jane!)

jane = nil


/*
 * Interaction between strong and unowned
 */

var harry: Customer? = Customer(name: "Harry Tanenbaum")
harry?.card = CreditCard(number: 4321_5678_9012_3456, customer: harry!)

// NOTE: Creditcard instances have no meaning once their owner is
// destroyed. Trying to retain such instances using strong references
// will result in undefined behavior. Uncomment the following piece of code
// to see the result of such an action.
/*
var cc2: CreditCard = harry!.card! // we use ! so as to ensure cc2 is not an optional
harry = nil
println("\(cc2)")
println("\(cc2.customer)")
*/

/******************************************************************************
 * Breaking reference cycles in closures
 *
 * We use weak and unowned keywords in the capture list to break the ref cycle.
 * Syntax of the capture list:
 * {[weak a, weak b, unowned c] (a: Type1, b: Type2) -> Type3 in
 *     ...
 * }
 ******************************************************************************/

class DoesSomething {
    var num = 0
    func incrementNum() {
        // Since the incrementor closure never lives past the instance of this class,
        // we can safely capture self using an unowned reference and still be
        // assured that self will not be used once this instance has been destroyed.
        let incrementor = {
            [unowned self] in
            self.num++
        }
        incrementor()
    }
    func gimmeNumIncrementor() -> () -> () {
        // The capture list catures self as a weak ref because once the closure is
        // returned, we have no control over its life time.
        return { [weak self] () -> () in
            self?.num++
            if self == nil {
                print("Sweat not. The cycle is broken and the instance we captured has been destroyed")
            }
        }
    }
}

var something: DoesSomething? = DoesSomething()
var incrementor = something?.gimmeNumIncrementor()
something?.num
incrementor?()
something?.num
something = nil
incrementor?()


