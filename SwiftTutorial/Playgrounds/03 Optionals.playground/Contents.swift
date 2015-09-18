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

/*********************************
 * nil
 *********************************
 *
 * nil is a special value. Much more speacial than NULL from C :)
 * It is so special, that Swift has a lot of syntax revolving around 
 * nil - Optionals really.
 */

var pointlessStats = ["A" : 358, "G" : 589, "P" : 94]
pointlessStats["M"] // nil is used to represent the absence of a value.

/*********************************
 * Optionals
 *********************************
 *
 * Optionals are types of variables that may or may not hold a value.
 *
 * Declaration:
 * var x : Type?
 */

var iOpt: Int?

iOpt = nil
iOpt = 29

var i:Int = 0

// i = nil  // ERROR. Non-optional types always have to hold a valid value.
// nil indicates absence of a value rather than being a special value.

// i = iOpt // ERROR

/*********************************
 * Forced Unwrapping
 *********************************
 *
 * Extracting value out of optionals. Also known as Forced Unwrapping
 * varName!
 */

if (iOpt != nil) { // Always check for nil before force unwrapping an optional.
    i = iOpt!
}

// The only reason the following statement is commented is that the playground
// has a bug. Setting iOpt to nil will result in an error on the previous statement
// i = iOpt! although iOpt does have an int at that point, and that statement is
// protected inside an if block that verifies that iOpt is not nil.
// iOpt = nil

// This statement though needs to be commented when written in a playground because
// it generates a runtime error if the statement above is uncommented. And that is
// a problem because the playground actually has to execute that line in order to
// display the result of that satement.
// i = iOpt! // What does this mean?? ... Run time error


// Safer way to extract optionals
if (iOpt != nil) {
    let j = iOpt!
    // use j
}

// Shortcut
if iOpt != nil {
    let j = iOpt!
}

/*********************************
 * Optional Binding
 **********************************
 *
 * if let constantName = someOptionalsName {
 *     // safely use constantName which contains the extracted
 *     // value from someOtopnalsName.
 * }
 *
 * if someOptionalsName is of type Type?
 * then constantName has type Type
 *
 * OR
 *
 * if var variableName = someOptionalsName {
 *
 * }
 *
 * Note, always prefer optional binding over force unwrapping.
 */

if let j = iOpt {
    print("Value extracted from iOpt is useable as \(j)")
}

// It is safe to use String interpolation on optionals, since it is based on
// a call to the description method defined in the optional. The output though
// is not what you might expect when the optional has a non-nil value.
"iOpt gives us \(iOpt)"

iOpt = nil
"iOpt gives us \(iOpt)"

/*********************************
 * Implicitly unwrapped optionals
 *********************************
 * var x: Type!
 * Equivalent to optionals in all respects except the syntax to unwrap the value 
 * out of it
 * var y:Type = x
 * instead of y = x!
 */

var iImplicitUnwrap: Int! = nil

iImplicitUnwrap = 27

// Extracting the value from an implicitly unwrapped optional
// 1. Implicit unwrapping
var anInt: Int = iImplicitUnwrap  // Runtime error if iImplicitUnwrap is nil

// You can use the same syntax on it as on an Optional
// 2. Optional binding
if let j = iImplicitUnwrap {
    // 3. Force unwrapping
    let k = iImplicitUnwrap!
    print("iImplicitUnwrap is useable as \(j)")
    "iImplicitUnwrap is useable as \(j) and \(k)"
}


// Notice the difference in string interpolation of Otionals versus implicitly unwrapped Optionals.
iImplicitUnwrap = 10
iOpt = 10
"\(iOpt) versus \(iImplicitUnwrap)"


/*********************************************
 * Optional Chaining
 **********************************************
 *
 * This works out as an alternative to forced unwrapping. It is especially
 * useful in avoiding deeply nested if let blocks.
 */


var numString = [0: "Zero", 1: "One", 2: "Two"]

if let str = numString[10] {
    print("10 -> \(str)")
} else {
    print("10: No conversion to word")
    numString[10] = "Ten"
}

numString

import Foundation // required for us to be able to use lowercaseString

// lower10 is deduced to be String?
var lower10 = numString[10]?.lowercaseString
lower10

var missing100 = numString[100]?.lowercaseString
missing100
missing100 = "Hello"

// If we are sure that the value exists, then we can force it out and the value,
// if successfully extracted, will have type String
var forcedLower10 = numString[10]!.lowercaseString
forcedLower10


// var forcedMissing100 = numString[100]!.lowercaseString // ERROR : runtime error


// What if numString itself was optional?

var optNumString: [Int:String]? = nil
optNumString = [Int:String]()
optNumString?[10] = "Ten"
optNumString


let lower10InOptDictionary = optNumString?[10]?.lowercaseString
lower10InOptDictionary // Deduced as String?

let lower10InForcedOptDictionary = optNumString![10]?.lowercaseString
lower10InForcedOptDictionary // Still deduced as String? because we only forced
// forced out the dictionary but not the value for the key.

let forcedLower10InForcedOptDictionary = optNumString![10]!.lowercaseString
forcedLower10InForcedOptDictionary // Deduced as String

let forcedLower10InOptDictionary = optNumString?[10]!.lowercaseString
forcedLower10InOptDictionary // Still deduced as String? because the chained
// unwrapping can fail at any point in the chain. The expression
// then should result in a nil on any failure. That gives us the ?
// And on success it results in a String, that gives us the String
// part.

// Optional chaining in the lvalue expression
optNumString?[10] = optNumString?[10]?.lowercaseString
optNumString

optNumString?[100] = optNumString?[100]?.lowercaseString
optNumString

// How do you find out if an optional chained expression resulted in a no-op?

//
// Chaining in the lvalue
//
// When you assign an rvalue to an optional-chained lvalue, the result of the
// expression is of type 'Void?'. If the lvaue is succesfully extracted
// after evaluation of the optional chaining, then the assignment proceeds
// as expected, and the expression returns a 'Void' (i.e. an empty tuple () ).
// Otherwise the lvalue derived from the optional chaining will be nil. And we
// cannot assign anything to a nil object. So the assignment fails, and the
// expression returns nil.
if (optNumString?[200] = "Two Hundred") != nil { // Success
    print("We did some great work over there, team!")
} else { // Failure
    print("In the end, we are just as strong as the weakest link!")
}

// Chaining in rvalue
// Equivalent to checking any Optional value.
// Interesting part to notice here is that the optional chain fails
// at optNumString?[100]? point. So it does not bother to invoke
// lowercaseString at all.
if optNumString?[100]?.lowercaseString != nil { // Success
    print("Found it!")
} else { // Failure
    print("Missed it.")
}


/*............STOP............
.
.
.
Come back to the last part only after finishing the Enumerations playground.
.
.
.
.
*/

// How do you think optional chaining implements the above behavior?
// It simply does switch based pattern matching

switch optNumString?[100] {
case nil:
    print("No value to call lowercaseString on")
case .Some(let someStr):
    print("found \(someStr)")
default:
    break
}


switch optNumString?[200] {
case nil:
    break
case .Some(let someStr):
    print("found [\(someStr)]. result should be [\(someStr.lowercaseString)]")
default:
    break
}

// Literal translation of optNumString?[N]?.lowercaseString
func getThatString(N: Int) -> String? {
    switch optNumString {
    case nil:
        return nil
    case .Some(let dictionary):
        switch dictionary[N] {
        case nil:
            return nil
        case .Some(let val):
            return val.lowercaseString
        default:
            return nil
        }
    default:
        return nil
    }
}

getThatString(100) // optNumString?[100]?.lowercaseString
getThatString(200) // optNumString?[200]?.lowercaseString


