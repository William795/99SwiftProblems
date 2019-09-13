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
        print(7.isPrime())
        print(10.isPrime())
        print(97.isPrime())
    }
    
    func greatestCommonDivisor() {
        print(Int.gcd(first: 1000, 300))
        print(Int.gcd(first: 18522, 38718))
        print(Int.gcd(first: 3958, 3474))
    }
    
    func isCoPrime() {
        print(1000.isCoprimeTo(other: 599))
        print(18522.isCoprimeTo(other: 38718))
        print(3958.isCoprimeTo(other: 3474))
    }
}
