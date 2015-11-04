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

import Foundation

/******************************************************************************
 * Overloading existing operators
 ******************************************************************************/
class Accumulator {
    var sum = 0
    init(_ initialSum: Int) {
        sum = initialSum
    }
}

/******************************************************************************
 * infix operators
 ******************************************************************************/
func + (a: Accumulator, b: Accumulator) -> Accumulator {
    return Accumulator(a.sum + b.sum)
}

let a = Accumulator(10)
let b = Accumulator(20)
var c = a + b + a + b

/******************************************************************************
 * prefix operators
 ******************************************************************************/
prefix func ++ (inout a: Accumulator) -> Accumulator {
    ++a.sum
    return a
}
let d = ++c
d
c

/******************************************************************************
 * postfix operators
 ******************************************************************************/
postfix func ++ (inout a: Accumulator) -> Accumulator {
    let res = Accumulator(a.sum)
    ++a.sum
    return res
}
var e = c++ // Notice that res is let while e is var. Those qualifiers apply on to
// the references rather than the object itself when we deal with
// reference types.
e
c
e = a

/*
 * Limitations:
 * '=' and '?:' are only two standard operators that cannot be overloaded
 */

/******************************************************************************
 * subscript operator
 ******************************************************************************/
extension Int {
    
    subscript(var i: Int) -> Int { // Read-only subscript
        var copySelf = (self >= 0) ? self : -self
        var digit = 0
        // i = 0 implies the caller wants digit in the ten's place
        for (; i >= 0; --i, copySelf /= 10) {
            digit = copySelf % 10
        }
        return digit
    }
    
    subscript(from: Int, to: Int) -> String {// Subscript with multiple parameters
        var result = ""
        for i in from..<to {
            result += String(self[i])
        }
        Array(result.characters.reverse())
        return result
    }
    /*
    e.g. of read-write subscript
    subscript(i: Int) {
    get {
    return something
    }
    set(someVal) {
    set something. return nothing.
    }
    
    */
    /*
    e.g. of variadic subscript
    subscript(indices:Int...) -> String {
    var result = ""
    for i in indices {
    result += String(self[i])
    }
    return result
    }
    */
}

1234[0]
1234[1]
-1234[2]    // Interesting. [ has higher precedence than unary -
(-1234)[2]
1234[3]
1234[4]
1234[100]

1234567890[3, 4]
1234567890[3, 7]


/******************************************************************************
 * Creating custom operators
 ******************************************************************************/
/*
 * Custom operators can begin with /, =, -, +, !, *, %, <, >, &, |, ^, ?, or ~
 * (or one of the Unicode characters defined in the grammar). After the first
 * character, combining Unicode characters are also allowed. You can also define
 * custom operators as a sequence of two or more dots (for example, ....)
 */

/******************************************************************************
 * infix operator
 ******************************************************************************/
infix operator --+ {associativity left precedence 100}
// infix operator --+ {} // default associativity is none and precedence 100.

func --+ (a: Accumulator, b: Accumulator) -> Accumulator {
    if a.sum >= b.sum {
        return Accumulator(a.sum - b.sum)
    } else {
        return Accumulator(a.sum + b.sum)
    }
}

let f = Accumulator(10)
let g = Accumulator(20)
f --+ g
f --+ g --+ g
f --+ g --+ g + g
(f --+ g) --+ (g + g)

/******************************************************************************
 * prefix operator
 ******************************************************************************/
prefix operator √ {} // {} needs to be emptry for prefix and postfix operators

prefix func √ (a: Accumulator) -> Accumulator {
    let sqrtOfSum = Int(sqrt(Double(a.sum)))
    return Accumulator(sqrtOfSum)
}

let h = Accumulator(64)
let i = Accumulator(65)
√h
√i
f + √h

/*
 * Limitations:
 * The operator disambiguation logic in the Swift compiler seems to rely a bit on
 * the developer for some help (documented as the rule may be). Simply paraphrased,
 * the rule is: When in doubt, use whitespaces to separate operators.
 */
f + √h      // OK
// f +√h    // ERROR : +√ isn't an operator we have defined
// f+ √h    // ERROR : We haven't defined postfix + operator
// f + √ h  // ERROR : Unary operator cannot be separated