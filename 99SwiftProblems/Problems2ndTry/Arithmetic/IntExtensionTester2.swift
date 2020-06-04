//
//  IntExtentionTester.swift
//  99SwiftProblems
//
//  Created by William Moody on 6/2/20.
//  Copyright © 2020 William Moody. All rights reserved.
//

import Foundation

class intExtensionTester {
    
    static let shared = intExtensionTester()
    
    // P 31
    func primeTest() {
        print(6.isPrime())
        print(7.isPrime())
        print(49.isPrime())
        print(47.isPrime())
    }
    
    // P 32
    func GCDTest() {
        print(Int.gcd(first: 36, 63))
        print(Int.gcd(first: 10, 55))
        print(Int.gcd(first: 173982, 928456))
        print(Int.gcd(first: 35, 64))
    }
    
    // P 33
    func coPrimeTest() {
        print(15.isCoprimeTo(other: 20))
        print(35.isCoprimeTo(other: 64))
        print(30.isCoprimeTo(other: 125))
    }
    
    // P 34
    func totientTest() {
        print(9.totient)
        print(10.totient)
        print(11.totient)
        print(36.totient)
    }
    
    // P 35
    func primeFactorsTest() {
        print(10.primeFactors)
        print(100.primeFactors)
    }
    
    // P 36
    func primeFactorMultiplicityTest() {
        print(10.primeFactorMultiplicityDict)
        print(100.primeFactorMultiplicityDict)
    }
}
