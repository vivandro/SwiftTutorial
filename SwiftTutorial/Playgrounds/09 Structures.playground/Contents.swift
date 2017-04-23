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
 * Structures: Skipping these for lack of time. But a few things that will help you understand these:
 * - Value types
 * - No inheritance
 * - No typecasting
 * - No deinitializers
 * - Unlike classes, structs get default memberwise initializers
 * - Prefix methods with mutating keyword if that method modifies anything in the
 *   struct.
 * - Unlike classes, value types can completely replace themselves by assigning
 *   a new instance to the self property from within a mutating function.
 *   This must be the basis of restricting calls to mutating methods on consts.
 * - String, Array, Dictionary, as well as Int Boolean etc. are Structs
 * Everything else is similar to Classes.
 ******************************************************************************/

// mutating
struct Stuff {
    var mutatingCalls = 0
    mutating func mutate() {// mutating is a necessary qualifier since this
        mutatingCalls += 1     // method modifies a property.
    }
    func printMutations() { // Mo need to use mutating.
        print("\(mutatingCalls)")
    }
    mutating func resetState() {
        self = Stuff()  // Can replace the whole struct from within mutatinf func.
        // This is something that cannot be done on classes.
    }
}

var stuff1 = Stuff()    // Default initializer. Possible only because
// we have defined default values for all members.
stuff1.mutate()
stuff1.printMutations()
stuff1.mutate()
stuff1.resetState()

let stuff2 = Stuff(mutatingCalls: 1)// Memberwise initializer
// stuff2.mutate() // ERROR: Cannot call mutating methods for 'let' variables
stuff2.printMutations()

