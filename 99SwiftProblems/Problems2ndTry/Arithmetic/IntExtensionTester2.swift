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
    
    func primeTest() {
        print(6.isPrime())
        print(7.isPrime())
        print(49.isPrime())
        print(47.isPrime())
    }
}
