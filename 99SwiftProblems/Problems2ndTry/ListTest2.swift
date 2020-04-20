//
//  ListTest2.swift
//  99SwiftProblems
//
//  Created by William Moody on 4/3/20.
//  Copyright © 2020 William Moody. All rights reserved.
//

import Foundation

class listTest {
    
    var listOne = List(1, 2, 4, 8, 9, 7, 5, 3, 20, 20, 15, 10)
    var listTwo = List("hi", "how", "are", "you", "?")
    var palendrome = List(1, 2, 3, 3, 2, 1)
    var nestedList = List<Any>(List<Any>(1, 1)!, 2, List<Any>(3, List<Any>(5, 8)!)!)
    
    static let shared = listTest()
    
    //P 01
    func printLastItemInList() {
        print(listOne?.last as Any)
        print(listTwo?.last as Any)
    }
    
    //P 02
    func printPennultimate() {
        print(listOne?.pennultimate as Any)
        print(listTwo?.pennultimate as Any)
    }
    
    //P 03
    func printKthElement() {
        print(listOne?[2] as Any)
        print(listTwo?[2] as Any)
    }
    
    //P 04
    func printListLength() {
        print(listOne?.length as Any)
        print(listTwo?.length as Any)
    }
    
    //P 05
    func printReverseList() {
        print(listOne?.reverse().value as Any)
        print(listTwo?.reverse().value as Any)
    }
}
