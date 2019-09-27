//
//  LogicAndCodes.swift
//  99SwiftProblems
//
//  Created by William Moody on 9/27/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation

//P46 (**) Truth tables for logical expressions.

func and(a: Bool, b: Bool) -> Bool {
    if a == true && b == true {
        return true
    }
    return false
}

func or(a: Bool, b: Bool) -> Bool {
    if a == true || b == true {
        return true
    }
    return false
}

func nand(a: Bool, b: Bool) -> Bool {
    if a == true && b == false || a == false && b == true {
        return true
    }
    return false
}

func nor(a: Bool, b: Bool) -> Bool {
    if a == true || b == true {
        return false
    }
    return true
}

func xor(a: Bool, b: Bool) -> Bool {
    if a == true && b == true {
        return false
    }
    return true
}

func impl(a: Bool,-> b: Bool) -> Bool {
    if a != b && b == false {
        return false
    }
    return true
}

func equ(a: Bool, b: Bool) -> Bool {
    if a == b {
        return true
    }
    return false
}
