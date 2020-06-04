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
// copied from my first attempt, mainly due to the fact that I don't really see a way to improve upon it in any real way, just by how Elucid's algorithm works. The above solution is already doing something in the vein of O(log) time and its hard to beat that

//P33 Determine whether two positive integer numbers are coprime.
extension Int {
    func isCoprimeTo(other: Int) -> Bool {
        if Int.gcd(first: self, other) == 1 {
            return true
        }
        return false
    }
}
// My first solution just copied and pasted P 22's solution and replaced the returning numbers with true/false with a check to see is there was a 1.
// I'm glad to see that I have improved somewhat since the last time I tried my hand at these

// P34 Calculate Euler’s totient function phi(m).
extension Int {
    var totient: Int {
        var totientAmount = self
        let primeFactors = self.primeFactors
        var previousPrimeFactor = 0
        for primeFactor in primeFactors {
            if previousPrimeFactor != primeFactor {
                if totientAmount == primeFactor {
                    totientAmount = totientAmount - 1
                } else if primeFactor != 1 {
                    let amountToRemove = totientAmount / primeFactor
                    totientAmount = totientAmount - amountToRemove
                }
            }
            previousPrimeFactor = primeFactor
        }
        return totientAmount
    }
}
// Kinda cheated by using P35's solution but when I saw that you can calulate totient's by using primefactors quite easily. I figured that doing it this was would be better than my previous 'loop through all numbers between 1 and self running .isCoPrime for each one' methood


// P35 Determine the prime factors of a given positive integer.
extension Int {
    var primeFactors: [Int] {
        var mutatableSelf = self
        var primeCheck = 2
        var primeArray: [Int] = []
        if mutatableSelf.isPrime() {
            return [1, mutatableSelf]
        }

        while mutatableSelf >= primeCheck {
            if mutatableSelf % primeCheck == 0 {
                mutatableSelf = mutatableSelf / primeCheck
                primeArray.append(primeCheck)
                primeCheck = 1
            }
            primeCheck += 1
        }
        return primeArray
    }
}
// Copied from my last go due to it alrady being fairly efficent

//P36 Determine the prime factors of a given positive integer - Part 2.
extension Int {
    var primeFactorMultiplicityDict: Dictionary<Int, Int> {
        var mutatableSelf = self
        var primeCheck = 2
        var primeDict: [Int: Int] = [:]

        if mutatableSelf.isPrime() {
            return [mutatableSelf: 1]
        }

        while mutatableSelf >= primeCheck {
            if mutatableSelf % primeCheck == 0 {
                mutatableSelf = mutatableSelf / primeCheck
                if primeDict[primeCheck] != nil {
                    primeDict[primeCheck]! += 1
                } else {
                    primeDict[primeCheck] = 1
                }
                primeCheck = 1
            }
            primeCheck += 1
        }
        return primeDict
    }
}
// Removed the very pointless loop-inside-loop at the end of my first solution and just had the function add to the dictionary as the while-loop is going
// another example of no knowing in the slightest what my past self was thinking
