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

for var index = 0; index < 3; ++index {
    print("index is \(index)")
}

for index in 1...5 { // 1..<5
    print("\(index) times 5 is \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]

// Enumerating over an Array (collection)
for name in names {
    print("Hello, \(name)!")
}

// Getting the array index in the enumeration
for (index, name) in names.enumerate() {
    print("\(index) -> \(name)")
}

// Partial enumeration
for name in names[1..<names.count] {
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
// Enumerating over a Dictionary
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

// Getting an index in the enumeration
for (index, (animalName, legCount)) in numberOfLegs.enumerate() {
    print("\(index) --> \(animalName)s have \(legCount) legs")
}

// No surprises in while and do-while

// if-else
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}


// switch case
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel") // No implicit fallthru
case "b": fallthrough       // Explicit fallthrough
    //case "c":       // A case mst have at least one statement
case "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}


// Working with tuples and ranges

let somePoint = (1, 0)
var iii:Int = 29;

switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
    iii = 0
case (_, 0): // For such pattern matching to work as expected, it is important to order the cases from specific on top to general going down the page
    print("(\(somePoint.0), 0) is on the x-axis")
    iii = 1
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
    iii = 2
case (-2...2, -2..<2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    iii = 3
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
    iii = 4
}

iii

// some more pattern matching

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


// Labelled break and continue ... Labels are only allowed at the beginning of loop and switch statements
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    if ++diceRoll == 7 { diceRoll = 1 }
    gameSwitch:    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
        break gameSwitch
    }
}
print("Game over!")


