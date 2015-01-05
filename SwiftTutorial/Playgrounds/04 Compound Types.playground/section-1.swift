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
 * Structs
 ******************************************************************************/

struct Rectangle {
    var width = 0
    var height = 0
}

let rect1 = Rectangle()

let rect2 = Rectangle(width: 200, height: 200)
// let rect3 = Rectangle(height: 200, width: 400) // ERROR: Arguments not provided
// in the same order as the porperty definitions.

struct Circle {
    var radius = 1  // Unit circle by default
    let shapeName = "Circle"
}

let cir1 = Circle()                                    // Default initializer
let cir2 = Circle(radius: 100, shapeName: "BigCircle") // Memberwise initializer

/******************************************************************************
 * Enums
 ******************************************************************************/
enum Directions {
    case North
    case South
    case East
    case West
}


var treasureDirection : Directions = Directions.North

switch treasureDirection {
case .North:
    println("Arctic circle")
case .South:
    println("In Antarctica")
case .East:
    println("Nippon")
case .West:
    println("New World")
}

// Enums with associated values.
enum Address {
    case Full(String, String, String)
    case Unknown
}

var joeysLocation = Address.Full("12345 Abc St", "Some City", "Some Country")
joeysLocation = .Unknown
var him = Address.Unknown

// if Address.Unknown == him { // ERROR
// The only way to reach out into the enum and get a hold of the 'associated value'
// is to use a switch-case. We have a separate playground that goes into further
// details related to enumerations. We will learn a little bit
// more about the switch case statement (in the Control Statements playground)
// before we move on to further details on enumerations with associated values.

/******************************************************************************
 * Getting the raw values
 ******************************************************************************/

enum DirectionsInt : Int {
    case North = 3
    case South
    case East
    case West
}

let eastInt = DirectionsInt.East.rawValue

// let eastInt2 = CompassPoint.East.toRaw() // ERROR


/******************************************************************************
 * Classes
 ******************************************************************************/

class VideoMode {
    var resolution = Rectangle()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someVideoMode = VideoMode()

/******************************************************************************
 * Identity Operations
 ******************************************************************************/
let someOtherVideoMode = VideoMode()

if someVideoMode === someOtherVideoMode {
    println("Video modes refer to the same object")
}

someOtherVideoMode.frameRate = 60.0

if someVideoMode !== someOtherVideoMode {
    println("Video modes do not refer to the same object")
}

// if someVideoMode == someOtherVideoMode // ERROR
// NOTE: The above statement does not compile because for custom classes, you
// have to provide some more code to implement what equality means.
// [Refer to Classes playground and operator overloading playground for details
// related to remedying this situation.]
//
// Identity operators on the other hand have a well defined meaning that is
// independant of the class definition.

/******************************************************************************
 * Lazy properties
 *
 * Syntax:
 * lazy var name: Type = defaultValue
 *
 * - Lazy properties are not initialized until they are used.
 * - They must be var and not let, because let properties must be initialized
 *   at instance creation.
 ******************************************************************************/
class TimeSink {
    // TimeSink is a class that performs some long running tasks right from the get go
    var timeSunk = 100 // This seems to be the minimum time it plans to sink. In millseconds!!
}

class CriticalTask {
    lazy var executeCommands = TimeSink()
    var commands = [String]()
}

let task = CriticalTask()
task.commands.append("command 1")
task.commands.append("command 2")
// executeCommands has not yet been initialized with the TimeSink object because we haven't
// refrred to executeCommands yet.

println(task.executeCommands.timeSunk)
// TimeSink instance was created as soon as we referred to the executeCommands
// property.


/******************************************************************************
 * Computed properties
 *
 * - Unlike stored properties, the instance does not actually reserve a storage
 *   for a value backing this property.
 * - These only provide getters and setters for a property with that name. These
 *   getter/setters then may refer to other properties and perform some
 *   computation to get/set values.
 * - Need to be declared var and not let, because their return value can change.
 * - Local and global variables can be computed as well.
 ******************************************************************************/

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point { // Has a getter and a setter
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) { // You get to name the parameter passed to the setter
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
    var bottomRightCorner: Point { // Providing just the getter makes this a read-only computed property.
        get {
            let x = origin.x + size.width
            let y = origin.y + size.height
            return Point(x: x, y: y)
        }
    }
    var bottomRightCornerCondensedCode: Point { // Shorthand for read-only computed properties.
        let x = origin.x + size.width
        let y = origin.y + size.height
        return Point(x: x, y: y)
    }
}

// Computed global/local variable
var backingStore = 2
var alwaysEven: Int { // Computed global(/local) variable
get {
    return backingStore
}
set {
    backingStore = newValue + newValue % 2
}
}

/******************************************************************************
 * Property Observers
 *
 * - Can add property observers to any properties except lazy stored properties.
 * - Can also add observers to inherited properties by overriding them.
 * - Interestingly enough, property observers are also available for global
 *   and local variables.
 ******************************************************************************/
class StepCounter {
    var willSetCounter = 0
    var didSetCounter = 0
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) { // If you don't provide a name, default name is newValue
            ++willSetCounter
            println("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            ++didSetCounter
            if totalSteps > oldValue  {
                println("Added \(totalSteps - oldValue) steps")
            } else {
                totalSteps = oldValue // Setting the property value inside property
                // observers does not trigger the observer again.
            }
        }
    }
}

let steps = StepCounter()
steps.totalSteps = 10
steps.totalSteps = 100
steps.totalSteps = 20

// "Property" observers for global/local variable
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

/******************************************************************************
 * Type Properties
 *
 * - static qualifier is used for type properties in a value type (struct/enum)
 * - class qualifier is used for type properties in a reference type (class)
 *
 ******************************************************************************/
struct BlahStruct {
    static var i = 100
}

BlahStruct.i = 25

class BlahClass {
    //class var i = 100 // ERROR: class variables are not yet supported.
    class var i: Int { // class computed properties however are supported even now.
        get{
        return 100
        }
        set {
            // no-op, though we could have done something with it.
            // Unfortunately, until we get support for backing class variables,
            // class setters cannot do much. Setting the value into some global variable
            // will be counter productive since that indirectly leaks the
            // name into global namespace, while the intention of using class
            // properties is to restrict the name to the type on which it has
            // been defined.
        }
    }
    // Note: It seems that the book does mention that classes can only have computed
    //       type properties. It's the compiler that gives the misleading error. But I
    //       haven't found sound reasoning behind this restriction. Until I find that,
    //       I am going to work under the assumption that at some point this restriction
    //       will be removed.
}

BlahClass.i

// So here's my solution to getting around that limitation!
class SneakyBlahClass {
    struct SneakyBackingStore {
        static var i: Int = 0
    }
    class var i: Int {
        get {
        return SneakyBackingStore.i
        }
        set {
            SneakyBackingStore.i = newValue
        }
    }
}

SneakyBlahClass.i = 20
SneakyBlahClass.i
var sneaky = SneakyBlahClass()
// sneaky1.i // ERROR: We can access type properties only via the type name

// But ofcourse callers can do this now
SneakyBlahClass.SneakyBackingStore.i = 23
SneakyBlahClass.i

// We should be able to avoid this once we learn more about access control.
// That will be discussed in the 'Classes' playground.


