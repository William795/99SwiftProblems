//
//  GlobalLogicFuntions.swift
//  99SwiftProblems
//
//  Created by William Moody on 6/11/20.
//  Copyright © 2020 William Moody. All rights reserved.
//

import Foundation

// P 46 Truth tables for logical expressions

func and(_ a: Bool, _ b: Bool) -> Bool {
    return a && b ? true : false
}

func or(_ a: Bool, _ b: Bool) -> Bool {
    return a || b ? true : false
}

func nand(_ a: Bool, _ b: Bool) -> Bool {
    return a && b ? false : true
}

func nor(_ a: Bool, _ b: Bool) -> Bool {
    return a || b ? false : true
}

func xor(_ a: Bool, _ b: Bool) -> Bool {
    return a == b ? false : true
}

func impl(_ a: Bool, _ b: Bool) -> Bool {
    return a && b == false ? false : true
}

func equ(_ a: Bool, _ b: Bool) -> Bool {
    return a == b ? true : false
}

func table(expression: (_ a: Bool, _ b: Bool) -> Bool) -> [[Bool]] {
    let trueTrueArray = [true, true, expression(true, true)]
    let trueFalseArray = [true, false, expression(true, false)]
    let falseTrueArray = [false, true, expression(false, true)]
    let falseFalseArray = [false, false, expression(false, false)]
    let tableArray: [[Bool]] = [trueTrueArray, trueFalseArray, falseTrueArray, falseFalseArray]
    return tableArray
}
// I'm not very comfortable with closures and expressions, so figuring out how to make the table function work took a couple hours.
// I got all the logic expressions down to 1 line each, which is nice improvement over the 4 or so lines previously.
// my table function needs work tho. Its more of a brute force solution, and is not scalable in the slightest (throwing in 1 more value in the expression would require twice as many lines of code)
// Hopefully I can come back to this when I understand closures and expressions better and make a proper scaling solution.
