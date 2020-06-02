//
//  File.swift
//  99SwiftProblems
//
//  Created by William Moody on 5/7/20.
//  Copyright © 2020 William Moody. All rights reserved.
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
