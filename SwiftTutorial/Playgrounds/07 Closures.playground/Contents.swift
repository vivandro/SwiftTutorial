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
 * Closures
 * No special keyword.
 * Similar to blocks in C and lambda's C++. But much simpler.
 * Functions are named closures.
 * Closures automatically capture values from the surrounding/enclosing context.
*************************************************************************/

/****
 * Simple Closure
 *
 * { (parameters) -> returnType in
 *     statements
 * }
 ****/

var greaterThan = { (x: Int, y: Int) -> Bool in
    return x > y
}


/****
 * Equivalence between functions and closures.
 ****/

var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella", ]

func leftToRightOrderingDescending(s1: String, s2: String) -> Bool {
    return s1 > s2
}

// Call to sort using a func
names.sortInPlace(leftToRightOrderingDescending)
names
// If we don't want to modify the source array, we can use the sort function instead.
// names.sort(backwards) // returns a sorted copy of the names array


// Same result with a closure
// leftToRightOrderingAscending
names.sortInPlace({ (s1: String, s2: String) -> Bool in
    return s1 < s2
})
names


/****
 * Inferred parameter and return types
 ****/

names.sortInPlace({ s1, s2 in return s1 > s2 })
names

/****
 * Implicit returns
 ****/
names.sortInPlace({ s1, s2 in s1 < s2 })
names

/****
 * Shorthand argument names
 ****/
names.sortInPlace({ $0 > $1 })
names

/****
 * Trailing closures
 ****/
names.sortInPlace { $0 < $1 }
names

/****
 * Operator functions
 ****/
names.sortInPlace(<) // The second argument is actually an operator function name
names


/****
 * map method
 ****/
var nums = [1,3,5,7,]
var evenizeUp = nums.map() {
    $0 + $0 % 2
}


/****
 * Capturing Values (How do you think this works internally?)
 * Closures are reference types (e.x. based on let)
 ****/
func makeIncrementor(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal:Int = 0
    return {
        runningTotal += amount
        return runningTotal // Ques: Why can't I drop this line as well?
        // The compiler gives error: () -> () cannot be converted to () -> Int
        // Is that a compiler bug related to type inference or am I missing something here?
        // Ans: The answer is that assignment expressions result in Void
        // return type. So, that's the information I was missing here.
    }
}

let incrementByTen = makeIncrementor(forIncrement: 10)

incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
incrementByTen()

/****
* Memory management with closures....Will get to it in ARC playground
****/
