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

// 1. Chained assignment: a = b = c
var i = 1
var j = 2
var k = 3

// i = j = k // ERROR. Unlike c, the assignment operator does not return a value.
// Potentially this helps with inadvertant errors related to using =
// instead of == in conditions.


// 2. Computed global/local variable
var backingStore = 2
var alwaysEven: Int { // Computed global(/local) variable
get {
    return backingStore
}
set {
    backingStore = newValue + newValue % 2
}
}

// 3. "Property" observers for global/local variable

var beforeMessage = ""
var afterMessage = ""
var paranoid: Int = 100 {
willSet{
    beforeMessage = "Caught paranoid being set to \(newValue)"
}
didSet {
    afterMessage = "Seems paranoid has been set to \(paranoid) from \(oldValue)"
}
}

beforeMessage
afterMessage
paranoid = 20
beforeMessage
afterMessage
paranoid = 10
beforeMessage
afterMessage



// 4. Assertions : Refer iBook for more details.
//                 Simple example is shown below.
let iForAssert = -1
// The following line is commented only because this assertion is guaranteed to
// fail at runtime, and playground actually runs it and flags it as an error.
//assert(iForAssert >= 0, "\(iForAssert) should have been >= 0")


/*
 * 5. Access Control : Refer iBook for more details.
 *                     Basic information is given below.
 * - Module versus source file level access control
 * - Keywords: public, internal, private
 * - The chapter starts simple and gets more complex. Few surprises.
 */
