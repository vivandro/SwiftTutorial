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
 * Value Types
 * (Values are copied when one variable is assigned to the other)
 *********************************
 * - All the basic types like Int, UInt, Float. Double, Boolean, Character, String
 * - Struct, Enum
 * - IMPORTANT : All the basic types are actually defined as structures in Swift in order 
 *   to provide value semantics in their operations: Int, UInt, Double, Float, String
 *
 * Reference Types:
 * - Classes, Functions, Closures
 * - Copying results in both variables/references referring the same instance.
 */

// Integers
Int.min // Int is the preferred type since type inference results in Int when you initialize a variable
        // to a number without specifying a type annotation. Using default as much as possible will pre-empt
        // the need to perform type conversions.
Int.max
Int8.max
Int16.max
Int32.max   // On a 32-bit machine Int is equivalent to Int32
Int64.max   // On a 64-bit machine Int is equivalent to Int64

UInt.max
UInt8.max
UInt16.max
UInt32.max
UInt64.max
UInt64.min

// Default type inference
var i = 1_600_000
var i16:Int16 = 0x0F
// i16 = i // ERROR: Cannot assign value of type Int to type Int16
// i = i16 // ERROR - Swift provides a high degree of type safety.

// Decimals
Float.infinity  // 32 bit (atleast 6 decimal digits)
Double.infinity // 64 bit (atleast 15 decimal digits)

// Default type inference
var deci = 23.1
var f:Float = 1.25e3
// f = deci // ERROR
// deci = f // ERROR

// Booleans
let niceDayToLearnSwift: Bool = true

// CountableClosedRange: Range
let range = 0...3 // Fun to explore this more later...or check the documentation right away.


// Strings
var name: String = "Joh"
var ch: Character = "n"

// Appending a string
name += "ny" // String + String

// Appending a Character
//name += ch // String + Character // This used to work, but at some point the language spec changed to the more non-intuitive version
name.append(ch) // String + Character
name  += "\u{301}" // String + Character Literal

// Indexing characters in a string.
let alphabet = "abcdefg"

alphabet[alphabet.startIndex]
alphabet[alphabet.characters.index(after: alphabet.startIndex)]
//alphabet[alphabet.endIndex] // runtime ERROR
alphabet[alphabet.characters.index(before: alphabet.endIndex)]
alphabet[alphabet.characters.index(alphabet.startIndex, offsetBy: alphabet.characters.count-1)]

let aIndex = alphabet.startIndex
// alphabet[aIndex+1]// ERROR: Binary operator '+' cannot be applied to operands of type 'String.index' and 'Int'
alphabet[alphabet.characters.index(after: aIndex)]

//alphabet[0] // ERROR: 'subscript' is unavailable: canot subscript String with an Int
// This is very annoying when dealing with strings.
// But, here's a workaround that makes life easy, while still providing the level of
// type safety that Swift promotes.
let stringArray = Array(alphabet.characters)
stringArray[0]


// Inserting and removing
name.remove(at: name.characters.index(before: name.endIndex))
name.insert("!", at: name.endIndex)
name.insert(contentsOf: " Gaddar".characters, at: name.characters.index(before: name.endIndex))
let charRange = name.startIndex...name.characters.index(name.startIndex, offsetBy: 3)
name.removeSubrange(charRange)

let intRange = 0...3
//name.removeRange(intRange) // ERROR: Int range is not equivalent to Index range

// String interpolation
let interpolated = "i contains \(i)\n whereas f contains \(f)"
let greeting = "Hello \(name)"

// Helpers
import Foundation // required to get the ability to use NSString methods on String
name.uppercased()
"What Is This".lowercased()
("Running".lowercased()).hasSuffix("ing")

// '.' operators Left associativity allows us to get rid of the paranthesis
"Running".uppercased().hasPrefix("RUN")

// Tuples
var tup: (Int, Float) = (10, 67.0)

// Extracting value from the tuples
// 1: Decompose each value into separate constants or variables
let (anInt, aFloat) = tup
anInt
aFloat

// 2: Name only the interesting values durinng decomposition
let (_, onlyFloat) = tup
onlyFloat

// 3. Name neither, but extract either. This is the least preferable of methods
// because it provides no information about our intention at this LOC and hence
// makes our code brittle.
tup.0
tup.1

// 4. Name the values at creation. This is by far my favourite method.
let planet: (name: String, population: Double) = ("Earth", 6.7e9)
planet.name
planet.population

// The names propogate on assignment since each tuple actually defines a type which can be inferred during assignment.
let namedTup2 = planet
namedTup2.name
namedTup2.population
// You may still use the other naming methods with this tuple. e.g.
planet.0
planet.1

// Some interesting asides :
// 1. You cannot compare two tuples directly
//planet == namedTup2 // ERROR
// This must be a side-effect of each tuple being a new type. Since it is
// a new unnamed type, we(and the compiler) have no opportunity to extend the type
// to define the '==' operation on this type.
// For named types, you (or the compiler) can add such operations using extensions.
// And yes, we do have operator overloading in Swift. Yay! We will definitely get to
// it towards the end.

// 2. Void is a tuple with no elements: ()


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
 * Typecasting
 *********************************/

var a = 1_600_000
var a16:Int16 = 0x0F
// a16 = a // ERROR
// a = a16 // ERROR - Swift provides a high degree of type safety.
a = Int(a16)
a16 = Int16(a)

// You can provide your own extensions on the Int class to allow it to convert
// from your cutom type to an Int. We will discuss extensions at a later point.

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
 * Type Aliases
 *********************************/

typealias Rank = UInt8

var participantRank: Rank = 10 ; // Reminder that semi-colons are acceptable to the compiler
var kk:UInt8 = 20;
kk = participantRank

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
 * Collection Types
 *********************************/

// Array
// Creation
var arrStrings = ["hello", "world"];
arrStrings.count

// Appending
arrStrings.append("boo")
// arrStrings += "baz" // ERROR
arrStrings += ["baz"]
arrStrings += ["foo", "bar"]
// arrStrings += [25] // ERROR


// Insertion
arrStrings.insert("ocean", at: 3)
arrStrings

// Replacement
arrStrings[2] = "blue"
arrStrings
arrStrings[3...5] = ["nada"]
arrStrings

// Deletion
let rm1 = arrStrings.remove(at: 4) // returns the removed entry
arrStrings

let rm2 = arrStrings.removeLast()     // returns the removed entry
arrStrings

// What is possible on constant Arrays?
let kArr = arrStrings

// kArr.removeLast() // ERROR
// kArr[0] = "aloha" // ERROR

// Conclusion: Arrays follow value semantics

// Multi-dimensional arrays
var arr1d = ["A", "B"] // For reference.
var arr2D = [arr1d, arr1d]
var arr2d2: [[Int]] = [ [11, 12, 13],
    [21] ]
var arr2d3: Array< Array<Int> > = [ [11, 12, 13],
    [21] ]
arr1d[0]
arr2D[1][1]

// Dictionary
var someStats = ["A" : 358, "G" : 589, "P" : 94]

someStats["A"]

//someStats["G"] = 590.17 // ERROR
someStats["G"] = 590

someStats["M"]
someStats

someStats["M"] = 45
someStats




// About nil ... Let's talk about it in Optionals


