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
// Or do that for P 48

// P 47 Truth tables for logical expressions - Part 2.
// redefine and, or, etc. as infix operators with left associativity and the corresponding precedence.
precedencegroup andPrecedence {
    associativity: right
}
infix operator ∧ : andPrecedence
func ∧ (_ a: Bool, _ b: Bool) -> Bool{
    return a && b ? true : false
}

precedencegroup orPrecedence {
    associativity: right
}
infix operator ∨ : orPrecedence
func ∨ (_ a: Bool, _ b: Bool) -> Bool{
    return a || b ? true : false
}

precedencegroup nandPrecedence {
    associativity: right
}
infix operator ⊼ : nandPrecedence
func ⊼ (_ a: Bool, _ b: Bool) -> Bool{
    return a && b ? false : true
}

precedencegroup norPrecedence {
    associativity: right
}
infix operator ⊽ : norPrecedence
func ⊽ (_ a: Bool, _ b: Bool) -> Bool{
    return a || b ? false : true
}

precedencegroup xorPrecedence {
    associativity: right
}
infix operator ⊕ : xorPrecedence
func ⊕ (_ a: Bool, _ b: Bool) -> Bool{
    return a == b ? false : true
}

precedencegroup implPrecedence {
    associativity: right
}
infix operator → : implPrecedence
func → (_ a: Bool, _ b: Bool) -> Bool{
    return a && b == false ? false : true
}

precedencegroup equPrecedence {
    associativity: right
}
infix operator ≡ : equPrecedence
func ≡ (_ a: Bool, _ b: Bool) -> Bool{
    return a == b ? true : false
}
// not sure if i'm missing something important, but it currently works.
// it dose feel a bit cluttered and I could remove all but 1 precedencegroup, but having them seperate allows me to change any one of them as I want (not that i'm likely to do so).
