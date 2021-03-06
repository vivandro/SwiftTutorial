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
 * Enumerations: 
 * Syntax might be weird, but remember just one thing:
 *   Enumerations can be implemented as a discriminated union of tuples.
 * That knowledge should let you wrap your head around most things related to
 * Enumerations.
 ******************************************************************************/

enum DiverseVals {
    case oneStr(String)
    case twoStrs(String, String)
    case oneInt(Int)
}

let os = DiverseVals.oneStr("Hola")
let ts = DiverseVals.twoStrs("Hola", "Amigo")
let oi = DiverseVals.oneInt(1)

switch os {
case .oneStr: // 'case' for C-style case
    print("OneStr")
default:
    print("default")
}

switch ts {
case let .twoStrs(a, b):// 'case let' for extracting the 'associated value' from the enum variable
    print("\(a) \(b)")
case .oneStr(let a):    // The let can be moved inside the parenthesis
    print("\(a)")
default:
    print("default")
}


/******************************************************************************
 * Enumerations with default values
 ******************************************************************************/

enum DefVals : Int {
    case one = 1
    case two, three, four   // Like C, these will get values 2, 3, 4.
    // case Uno = 1 // ERROR. Unlike in C, Swift forces all cases to have
    // unique raw values
    case seven = 7, eight, nine
    case five = 5
}

// Extracting the default/raw value
let val1: Int = DefVals.one.rawValue

// Creating a variable from enumerations
let one = DefVals.one

// Creating a variable from raw values
let six = DefVals(rawValue: 6)  // This is possible because raw value enums
// automatically get a raw value initializer.
six?.rawValue
let five = DefVals(rawValue: 5) // DefValue?
five?.rawValue  // Int?
five!.rawValue  // Int

/******************************************************************************
 * mutating self
 *
 * You are allowed to replace the entire enum instance via the self property
 * from within mutable functions in value types. This ability is especially
 * useful in enums where a mutating func can be called to perform a state
 * transition in an elegant fashion.
 ******************************************************************************/
enum TrafficLight {
    // var switchingFromRed = false // ERROR : enums cannot contain stored properties
    // This leads to an interesting solution that
    // requires us to use associated values.
    
    case red, yellow(switchingFromRed: Bool), green
    
    mutating func next() {
        switch self {
        case .green:
            self = .yellow(switchingFromRed: false)
        case .yellow(let switchedFromRed):
            self = (switchedFromRed == true ? .green : .red)
        case .red:
            self = .yellow(switchingFromRed: true)
        }
    }
}


