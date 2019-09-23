//
//  IntExtensionTester.swift
//  99SwiftProblems
//
//  Created by William Moody on 9/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation

class IntExtenstensionTester {
    
    static let shared = IntExtenstensionTester()
    
    func isPrime() {
        //P31 (**) Determine whether a given integer number is prime.
        print(7.isPrime())
        print(10.isPrime())
        print(97.isPrime())
    }
    
    func greatestCommonDivisor() {
        //P32 (**) Determine the greatest common divisor of two positive integer numbers.
        print(Int.gcd(first: 1000, 300))
        print(Int.gcd(first: 18522, 38718))
        print(Int.gcd(first: 3958, 3474))
    }
    
    func isCoPrime() {
        //P33 (*) Determine whether two positive integer numbers are coprime.
        print(1000.isCoprimeTo(other: 599))
        print(18522.isCoprimeTo(other: 38718))
        print(3958.isCoprimeTo(other: 3474))
    }
    
    func totient() {
        //P34 (**) Calculate Euler’s totient function phi(m).
        print(10.totient)
        print(100.totient)
        print(1000.totient)
    }
    
    func primeFactors() {
        //P35 (**) Determine the prime factors of a given positive integer.
        print(10.primeFactors)
        print(100.primeFactors)
    }
    
    func primeFactorMultiplicityDict() {
        //P36 (**) Determine the prime factors of a given positive integer - Part 2.
        print(10.primeFactorMultiplicityDict)
        print(100.primeFactorMultiplicityDict)
    }

    func goldbachTest() {
        //P40 (**) Goldbach’s conjecture.
        print(10.goldbach())
        print(28.goldbach())
        print(100.goldbach())
    }
    
    func printGoldbachList() {
        //P41 (**) A list of Goldbach compositions.
        Int.printGoldbachList(range: 9..<21)
    }
}
