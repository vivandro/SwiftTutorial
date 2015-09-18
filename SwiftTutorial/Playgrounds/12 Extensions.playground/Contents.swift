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
// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 * You can use extensions to extend an existing type to add anything to it that you
 * could when you defined the type (enum, struct, class) except the following:
 * - deinit
 * - designated initializer (but you are allowed to write convenience initializers
 *   in extensions)
 * - override existing methods, including existing initializers
 * - new base class
 */

// Short example

extension Int {
    func rep(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
    
    subscript(var i: Int) -> Int {
        var copySelf = (self >= 0) ? self : -self
        var digit = 0
        // i = 0 implies the caller wants digit in the ten's place
        for (; i >= 0; --i, copySelf /= 10) {
            digit = copySelf % 10
        }
        return digit
    }
}

var ten = 10

2.rep {
    ten *= 10
}

ten

1234[0]
1234[1]
-1234[2]    // Interesting. [ has higher precedence than unary -
(-1234)[2]
1234[3]
1234[4]
1234[100]

