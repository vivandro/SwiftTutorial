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
 * Variables and Constants
 *********************************/

// Variable definition
var i: Int = 24
i = 50 // OK.


// Constant definition
let k: Int = 42
// k = 45 // ERROR.


// Type inference is a really big theme in most Swift features.
var j = 45 // j is inferred by the compiler to be of type `Int` because 45 is inferred to be of type `Int`.
var j2: Int8 = 45 // 45 is inferred by the compiler to be of type `Int8` because the developer has specified the
    // type of j2 as `Int8`.
// But so is type safety. So automatic type conversion is not done even though it might
// be obvious to the compiler as to the correct type conversion that should be performed.
// let jj: Int = Int16(2) // ERROR.  cannot convert value of type `Int16` to specified type `Int`.

// Variables, constants need to be assigned values before they can be used
var w: Int
// w += 1 // ERROR: Variable 'w' passed by reference before being initialized
// Can you guess why the compiler thinks 'w' is being "passed" by reference?

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

/*********************************
 * Value vs Reference Type Variables
 *********************************/

// Value types in action
var valI: Int = 100
var valJ = valI

valI // 100
valJ // 100

valJ = 50

valI // 100
valJ // 50

// Reference types in action
class IntHolder {
    var valI : Int = 20;
}

var refI: IntHolder = IntHolder()
var refJ = refI

refI.valI // 20
refJ.valI // 20

refJ.valI = 10

refI.valI // 10
refJ.valI // 10

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

/*********************************
 * Naming variables/constants
 *********************************/

var x = 0.0, y = 0.0, z = 0.0

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
*/
// The variables can also be named in unicode.
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"


// Just FYI, this is a reasonable way to declare multiple variables of the same type in a single statement
// without specifying independent type annotations.
var a1, b1, c1 : String
// var a2, b2, c2 = 29 // ERROR: because type inference only works for the variables to which the value is assigned.

// BAD, but legal, style. Declaring variables of different types in a single statement.
var v1 = 26,      v2 = "hello"
let v3: Int = 52, v4: String = "hola"

// Moving forward, I am going to avoid discussions around syntax that is legal but best avoided.
// One such example is :
var `var` = "Why would I even insist on such a name!"
/* This /* is another */ such example. Nested multiline comments are legal. */
// I promise, we will have no such digressions in the future.

/*********************************
 * Printing variables via print
 *********************************/
// String Interpolation is the technique used to convert variables into their String descriptions.
// Here's the syntax for this:
print("x = \(x)")

var yStr = "y is \(y)"
print(yStr)
// print() also accepts variable number of printable objects, custom separator and custom end-of-string string.
print("x = \(x)", yStr, separator: " --:-- ", terminator: ". THE END.\n")

