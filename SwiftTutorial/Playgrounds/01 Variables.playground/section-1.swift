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
i = 50 // Obviously, OK


// Constant definition
let k: Int = 42
// k = 45 // Obviously, ERROR


// Type inference <--- is a really big theme in most Swift features
var j = 45 // j is of type Int


// Variables, constants need to be assigned values before they can be used
var w: Int
// w++ // ERROR

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

valI
valJ

valJ = 50

valI
valJ

// Reference types in action
class IntHolder {
    var valI : Int = 20;
}

var refI: IntHolder = IntHolder()
var refJ = refI

refI
refJ

refJ.valI = 10

refI
refJ

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


// Just FYI, this is a reasonable way to declare multiple variables of the same type in a single statement without specifying independent type annotations.
var a1, b1, c1 : String
// var a2, b2, c2 = 29 // ERROR: because type inference only works for the variables to which the value is assigned.

// Before a variable can be used

// BAD, but legal, style. Declaring variables of different types in a single statement.
var v1 = 26,      v2 = "hello"
let v3: Int = 52, v4: String = "hola"

// Moving forward, I am going to avoid discussions around syntax that is legal but best avoided.
// One such example is :
var `var` = "Why would I even insist on such a name!"
/* This /* is another */ such example */
// I promise, we will have no such digressions in the future.

/*********************************
 * Printing variables via println
 *********************************/
// String Interpolation is the technique used to convert variables into their String descriptions.
// Here's the syntax for this:
println("x = \(x)")

var yStr = "y is \(y)"
println(yStr)

