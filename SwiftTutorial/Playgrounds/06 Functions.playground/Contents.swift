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

/*************************************************************************
 * Functions
 *     func keyword
 *************************************************************************/

// A simple function with two arguments and returns a value
func maxOfTwo(_ a: Int, b: Int) -> Int {
    return a > b ? a : b
}
print(maxOfTwo(-11, b: 10))


// A function with zero arguments and no returns value
func sayHelloWorld() -> Void {
    print("Hello World")
}
sayHelloWorld()

// Shorter syntax for the return type
//     Void is equivalent to an empty tuple ()
func sayHelloWorld2() -> () {
    print("Hello World")
}
sayHelloWorld2()


// An even shorter syntax
//  No need to specify the return type if you are not going to return anything
func sayHelloWorld3() {
    print("Hello World")
}
sayHelloWorld3()

/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/

/*************************************************************************
 * - External parameter names
 * - Default values
 *************************************************************************/

func join(string s1: String = "hello", toString s2: String = "world", withJoiner joiner: String = " ") -> String {
    return s1 + joiner + s2
}

var s1 = join(string: "hello", toString: "world", withJoiner: ", ")
var s2 = join(string: "hello", toString: "world")

// As long as the arguments we provide are in order, we can drop any parameter that has a default value
var s3 = join(toString: "world") // dropped 1st and 3rd arguments
var s4 = join(string: "hello", withJoiner: ", ") // dropped 2nd argument out of 3

// Despite having names, parameters still need to maintain the order defined
// in the functions signature.
// var s42 = join(string: "hello", withJoiner: ", ", toString"chaos") // ERROR

/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/
/*************************************************************************
 *
 * 1. Providing default values to arguments results in automatic definition
 *    of external parameter names that are exactly same as internal parameter names
 * 2. Turns out the external parameter names are part of the function type.
 *    This enables us to overload functions based on variations in these names.
 * 3. Discarding the external name parameter generated for arguments with default
 *    values
 *************************************************************************/

func join(_ s1: String, s2: String = "world", joiner: String = " ") -> String {
    return s1 + joiner + s2 + " 2nd overload"
}
var s5 = join("hello", joiner: ", ")
// var s52 = join("hello", ", ") // ERROR due to ambiguity

func someFoo(_ a: Int = 29, b: Int = 32) -> Int {
    return a * b * 2
}
someFoo(100, b: 10)

// We can discard the automatically generated external parameter name by providing _
// as its replacement.
func someFoo(_ a: Int = 29, _ b: Int = 32) -> Int {
    return a * b * 2
}
someFoo(200, 20)


/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/
/*************************************************************************
 * Shorthand External Parameter Names
 *     #
 *************************************************************************/

// A func that forces unnamed parameters
func containsCharacter(_ string: String, characterToFind: Character) -> Bool {
    for character in string.characters {
        if character == characterToFind {
            return true
        }
    }
    return false
}

containsCharacter("Hello", characterToFind: "H")
//containsCharacter(string: "Hello", characterToFind: "H") // ERROR because the parameters were not intended to be named

// A func that forces named parameters
func containsCharacter(string: String, characterToFind: Character) -> Bool {
    for character in string.characters {
        if character == characterToFind {
            return true
        }
    }
    return false
}

containsCharacter(string: "Hello", characterToFind: "H")
// containsCharacter("Hello", "H") // ERROR because the # provides named parameters. And when we have named parameters, we are forced to use them.

/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/

/*************************************************************************
 * Variadic parameters
 *     Type...
 * A function can have at most one variadic parameter and it must be the last
 * parameter in its parameter list.
 * The value passed to the variadic parameter is accessible inside the function
 * as an array [Type]
 *************************************************************************/

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8, 19)
var primes = [3.0, 5, 7, 11, 13, 17, 19]
// arithmeticMean(primes)   // ERROR : You cannot directly pass an array to a variadic parameter.
//         This seemed reasonable enough to try and I had found that
//         this was acceptable syntax until Xcode 6 beta 3

/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/
/*************************************************************************
 * inout
 *     Required only for value type arguments
 *************************************************************************/

func swapTwoInts(_ a: inout Int, b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var oneInt = 20
var anotherInt = 30
swap(&oneInt, &anotherInt)
oneInt
anotherInt

class IntContainer {
    var containedInt = 100
}
func swapTwoInts(_ a: inout IntContainer, b: inout IntContainer) {
    let temporaryA = a.containedInt
    a.containedInt = b.containedInt
    b.containedInt = temporaryA
}
var oneContainedInt = IntContainer()
oneContainedInt.containedInt = 20
var anotherContainedInt = IntContainer()

oneContainedInt
anotherContainedInt
swapTwoInts(&oneContainedInt, b: &anotherContainedInt)
oneContainedInt
anotherContainedInt

func swapTwoInts(_ a: IntContainer, b: IntContainer) {
    let temporaryA = a.containedInt
    a.containedInt = b.containedInt
    b.containedInt = temporaryA
}

oneContainedInt
anotherContainedInt
swapTwoInts(oneContainedInt, b: anotherContainedInt)
oneContainedInt
anotherContainedInt
/*
 * Things worth noting in the examples above:
 * - inout is part of the function type and allows us to overload based on it.
 * - inout is unnecessary for reference types.
 */

/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/
/*************************************************************************
 * function types as arguments
 *************************************************************************/

// Notice the lack of * that arguments of function point types take.
func mathResult(_ mathFunction: (Int, Int) -> Int, a: Int, b: Int) -> Int {
    return mathFunction(a, b)
}

func addTwoInts(_ a: Int, b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: inout Int, b: Int) -> Int {
    return a * b
}
func exorTwoInts(oneInt a: Int, b: Int) -> Int {
    return a ^ b
}


mathResult(addTwoInts, a: 3, b: 5)
// mathResult(multiplyTwoInts, 3, 5) // ERROR: Since inout is part of the function
// type, multiplyTwoInts fails to pass type check.

mathResult(exorTwoInts, a: 1, b: 2)  // External parameter names don't seem to be
// part of the function type.


/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/
/*************************************************************************
 * Nested functions
 * Returning functions
 * Storing context
 *************************************************************************/

func chooseStepFunction(_ backwards: Bool) -> (Int) -> Int {
    func stepForward(_ input: Int) -> Int { return input + 1 }
    func stepBackward(_ input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}
var currentValue = -4
let moveCloserToZero = chooseStepFunction(currentValue > 0)
// moveCloserToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveCloserToZero(currentValue)
}
currentValue

chooseStepFunction(true)(2)
chooseStepFunction(false)(2)

func chooseStepFunction(backwards: Bool, step: Int) -> (Int) -> Int {
    // Notice that :
    // 1. External paramter names have no meaning when internal functions are returned.
    // 2. The value of the step parameter is captured within the internal functions.
    func stepForward(input: Int) -> Int { return input + step }
    func stepBackward(input: Int) -> Int { return input - step }
    return backwards ? stepBackward : stepForward
}

var stepB = chooseStepFunction(backwards: true, step: 3)
var stepF = chooseStepFunction(backwards: false, step: 5)
stepF(10)
chooseStepFunction(backwards: true, step: 3)(10)
stepB(10)
chooseStepFunction(backwards: false, step: 5)(10)


/*
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
*/
/*************************************************************************
 * Currying:
 * When a function returns another function, it is called currying. Technically, curried functions
 * are used to break a function that has "too many" arguments into a series of functions that split
 * the arguments amongst them, usually in the same order as the original single function had them.
 *
 * In it's simplest form though, it is nothing but a function returning another function which may
 * in turn return another function.
 *
 * Currying is so common and deemed useful in functional languages that Swift introduces a special
 * syntax to make writing such functions easier by getting rid of the unnecessary internal
 * functions, while still allowing the caller to break the function apart into
 * meaningful chunks.
 *************************************************************************/
func step(_ backward: Bool, _ quanta: Int, _ val: Int) -> Int {
    return val + (backward ? -quanta : quanta)
}

// Notice that for some reason Swift forces us to use names for parameters of every but the first parameter.
// We should ignore the reason for this, but my guess if that this has something to do with the
// compiler converting curried functions into anonymous classes. For class methods, parameter names
// are optional for the first parameter, but compulsory for the rest of them(unless explicitly
// suppressed by the method using _
step(true)(3)(val: 10)


var fwd = step(false)
var fwdBy5 = fwd(5)
fwdBy5(val: 10)
fwdBy5(val: 20)
fwd(10)(val: 10)
