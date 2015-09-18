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


/************************
 * Generic Functions
 ************************/
func mySwap<T>(inout a:T, inout b:T) -> Void {
    let c = a
    a = b
    b = c
}

var i1 = 20
var i2 = 40
mySwap(&i1, b: &i2)
i1
i2

var s1 = "hello"
var s2 = "world"
mySwap(&s1, b: &s2)
s1
s2

/***********************
 * Generic Types
 ***********************/
class MyStack<T> {
    var items: [T] = []
    
    func push(item: T) {
        items.append(item)
    }
    
    func pop() -> T? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
}

let st = MyStack<Int>()
st.push(10)
st.push(20)
st.push(30)
st.push(40)

st.pop()
st.pop()
st.pop()
st.pop()
st.pop()
st.pop()

/**********************
 * Generic Extensions
 **********************/
extension MyStack {
    func peek() -> T? { // IMP: Generic arguments are not allowed on extensions.
        // So they have to use the same typename as used in the
        // generic type they are extending. This is probably a
        // safeguard against accidental addition of more general types.
        if items.isEmpty {
            return nil
        } else {
            return items[items.count - 1]
        }
    }
}

st.push(25)
st.peek()




/************************
 * Type Constraints in generic functions and types.
 ************************/
/*
The following code does not compile:
func comp<T>(a: T, b: T) -> Bool {
return a == b;
}

Unlike other languages, Swift compiler checks the correctness of the template
function at definition rather than instantiation. This means it checks T is a type
that allows == operator between two instances of T.
*/
func comp<T: Equatable>(a: T, b: T) -> Bool {
    return a == b;
}



/***********************
 * Generic Protocols
 ***********************/
protocol Appendable {
    // V is said to be the 'associated type' of this protocol.
    typealias V // Similar to extensions, protocols cannot use the <T> syntax to
    // parametrize types. Instead, they need to define it via the
    // typealias keyword which is used elsewhere to declare aliases for
    // types. Unlike an extension, a protocol is not associated with a
    // specific type. This means it gets to decide its own name for the
    // generic type it will use.(And ofcourse there is no way to deduce
    // a universal name while we write the protocol definition. It can
    // only be known during protocol adoption).
    mutating func append (item: V) // using mutating allows Structs to adopt this
    // protocol while still allowing "let" consts.
}

extension MyStack : Appendable {
    //typealias V = T   // Not necessary since the compiler can infer the typealias
    // from the arguments of the append method.
    func append(item: T) {
        print("no-op")
    }
}

/*************************
 * Type Constraint part 2 : The where clause.
 *************************/
// Note:
// 1. We use , to separate multiple clauses
// 2. I would've been a good idea to use a more meaningful alias than V in Appendable
func appendableAndComparable<T where T:Appendable, T.V:Comparable>(a: T) -> Bool {
    return true // Any call to this func will either fail compilation, or will
    // be guaranteed to pass the constraints specified in the where clause.
}

// appendableAndComparable(20) // ERROR
appendableAndComparable(s