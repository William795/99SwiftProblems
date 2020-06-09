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

// P37 Calculate Euler’s totient function phi(m) (improved).
// using phi(m) = (p1-1)*p1(m1-1) * (p2-1)*p2(m2-1) * (p3-1)*p3(m3-1) * …
extension Int {
    var totientImproved: Int {
        var totient = 1
        let primeFactorDict = self.primeFactorMultiplicityDict
        let primeFactorDictKeys = primeFactorDict.keys
        for key in primeFactorDictKeys {
            let multiplicity = primeFactorDict[key]!
            var exponantEndValue = 1
            // if and loop statements for simluating an exponant because Swift dosn't have exponants for Ints
            if multiplicity - 1 > 0 {
                for _ in 1...multiplicity - 1 {
                    exponantEndValue = exponantEndValue * key
                }
            }
            totient = (key - 1) * exponantEndValue * totient
        }
        return totient
    }
}
// not really sure if this is actually better than my other solution (tho it is much much better than my first solution)
// When tested using the measure function in XCTest it was generally a wash for which performed better

// P 38 is a comparison of my solutions to P 34 and P 37, which I have already done.

// P 39 A linked list of prime numbers
extension Int {
    static func listPrimesInRange(range: Range<Int>) -> [Int] {
        var allPrimeNumbers = [2]
        var returningPrimeNumbers: [Int] = []
        if range.lowerBound > 2 {
            allPrimeNumbers = listPrimesInRange(range: 1..<range.lowerBound)
            allPrimeNumbers.insert(2, at: 0)
        }
        for number in range{
            
            var numberOfMultiples = 0
            for i in 0...allPrimeNumbers.count - 1 {
                let Prime = allPrimeNumbers[i]
                if number <= 1{
                    numberOfMultiples += 1
                    break
                }else if number <= 2{
                    numberOfMultiples += 1
                    break
                }else if number % Prime == 0 {
                    numberOfMultiples += 1
                    break
                }
            }
            if numberOfMultiples == 0{
                allPrimeNumbers.append(number)
                returningPrimeNumbers.append(number)
            }
        }
        return returningPrimeNumbers
    }
}
// This is a modified solution that I came up with about a year ago, due to this there are quite a few if statements there for just one ot two specific things so it generally look fairly messy.
// That said, I didn't really change the core idea, (compare each number to an array of prime numbers) just tweaked some things to make it more efficent


//P40 (**) Goldbach’s conjecture.
extension Int {
    func goldbach() -> (Int, Int) {
        if self % 2 != 0 {
            return (0,0)
        }
        let primeArray = Int.listPrimesInRange(range: 1..<self)
        for i in primeArray {
            for p in primeArray {
                if i + p == self {
                    return (i, p)
                }
            }
        }
        return (0,0)
    }
}
// took my first solution and replaced the loop to get the prime array with the previous problem's solution
// I'm not a fan of looping the primeArray within the prime array but i'm not sure how else to solve it

// P 41 A list of Goldbach compositions.
extension Int {
    static func printGoldbachList(range: Range<Int>) {
        for i in range {
            let primeArray = i.goldbach()
            let firstInt = primeArray.0
            let secondInt = primeArray.1
            if firstInt != 0 {
                print("\(i) = \(firstInt) + \(secondInt)")
                
            }
        }
    }
}
// pretty simple to just loop through the given range and run each value through the goldbach func
