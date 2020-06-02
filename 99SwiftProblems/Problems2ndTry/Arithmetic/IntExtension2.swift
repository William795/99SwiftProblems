//
//  File.swift
//  99SwiftProblems
//
//  Created by William Moody on 5/7/20.
//  Copyright © 2020 William Moody. All rights reserved.
//

import Foundation
//P31 Determine whether a given integer number is prime.
extension Int {
    func isPrime() -> Bool {
        let number = self
        for num in 2...(number / 2) {
            if number % num == 0 {
                return false
            }
        }
        return true
    }
}
// a basic solution which just tests every number from 2 to whatever the number/2
// not a great solution, could easily shave off quite a bit by adding a blacklist (say if it is odd skip all even numbers ect...)
// something that can be improved upon

//P32 Determine the greatest common divisor of two positive integer numbers.
extension Int {
    static func gcd(first: Int, _ second: Int) -> Int {
        var mutatableFirst = first
        var mutatableSecond = second

        while mutatableFirst % mutatableSecond != 0 || mutatableSecond % mutatableFirst != 0 {
            if mutatableFirst > mutatableSecond {
                mutatableFirst = mutatableFirst % mutatableSecond
            } else {
                mutatableSecond = mutatableSecond % mutatableFirst
            }
            if mutatableFirst == 0 || mutatableSecond == 0 {
                return mutatableFirst > mutatableSecond ? mutatableFirst : mutatableSecond
            }
        }
        return mutatableFirst > mutatableSecond ? mutatableFirst : mutatableSecond
    }
}
// Solution based on Elucid's algorithm and works by dividing the number into eachother and taking the remainder untill the remainder is 0 in which you have the GCD
// copied from my first attempt, mainly due to the fact that I don't really see a way to improve upon it in any real way
// just by how Elucid's algorithm works the above solution is already doing O(log) time and its hard to beat that
