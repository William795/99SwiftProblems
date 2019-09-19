//
//  IntExtension.swift
//  99SwiftProblems
//
//  Created by William Moody on 9/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation

extension Int {
    //P31 (**) Determine whether a given integer number is prime.
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

extension Int {
    //P32 (**) Determine the greatest common divisor of two positive integer numbers.
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

extension Int {
    //P33 (*) Determine whether two positive integer numbers are coprime.
    func isCoprimeTo(other: Int) -> Bool {
        var mutatableFirst = self
        var mutatableSecond = other
        
        while mutatableFirst % mutatableSecond != 0 || mutatableSecond % mutatableFirst != 0 {
            if mutatableFirst > mutatableSecond {
                mutatableFirst = mutatableFirst % mutatableSecond
            } else {
                mutatableSecond = mutatableSecond % mutatableFirst
            }
            if mutatableFirst == 1 || mutatableSecond == 1 {
                return true
            } else if mutatableFirst == 0 || mutatableSecond == 0 {
                return false
            }
        }
        return false
    }
}

extension Int {
    //P34 (**) Calculate Euler’s totient function phi(m).
    var totient: Int {
        var totientAmount = 0
        
        for i in 1...self {
            if i.isCoprimeTo(other: self) {
                totientAmount += 1
            }
        }
        return totientAmount
    }
}


extension Int {
    //P35 (**) Determine the prime factors of a given positive integer.
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

extension Int {
    //P36 (**) Determine the prime factors of a given positive integer - Part 2.
    var primeFactorMultiplicityDict: Dictionary<Int, Int> {
        var mutatableSelf = self
        var primeCheck = 2
        var primeDict: [Int: Int] = [:]
        var primeArray: [Int] = []
        
        if mutatableSelf.isPrime() {
            return [mutatableSelf: 1]
        }
        
        while mutatableSelf >= primeCheck {
            if mutatableSelf % primeCheck == 0 {
                mutatableSelf = mutatableSelf / primeCheck
                primeArray.append(primeCheck)
                primeCheck = 1
            }
            primeCheck += 1
        }
        // Bleg o(n)^2 come back and fix it
        for i in primeArray {
            var numberOfPrime = 0
            for x in primeArray {
                if i == x {
                    numberOfPrime += 1
                }
            }
            primeDict[i] = numberOfPrime
        }
        return primeDict
    }
}
