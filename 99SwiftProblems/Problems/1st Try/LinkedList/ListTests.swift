////
////  ListTests.swift
////  99SwiftProblems
////
////  Created by William Moody on 9/6/19.
////  Copyright © 2019 William Moody. All rights reserved.
////
//
//import Foundation
//
//class listTest {
//    var listOne = List(1, 2, 4, 8, 9, 7, 5, 3, 20, 20, 15, 10)
//    var palendrome = List(1, 2, 3, 3, 2, 1)
//    var nestedList = List<Any>(List<Any>(1, 1)!, 2, List<Any>(3, List<Any>(5, 8)!)!)
//
//    static let shared = listTest()
//
//    func printListLast() {
//        //P01 (*) Find the last element of a linked list.
//        guard let list = listOne else {return}
//        print(list.last)
//    }
//
//    func pennultimate() {
//        //P02 (*) Find the last but one element of a linked list.
//        guard let list = listOne else {return}
//        print(list.penultimate!)
//    }
//
//    func findSpecifiedIndex() {
//        //P03 (*) Find the Kth element of a linked list.
//        guard let list = listOne else {return}
//        print(list[2]!)
//    }
//
//    func findNumberOfElementsInList() {
//       // P04 (*) Find the number of elements of a linked list.
//        guard let list = listOne else {return}
//        print(list.length)
//    }
//
//    func reverse() {
//        //P05 (*) Reverse a linked list.
//        guard let list = listOne?.reverse() else {return}
//        print(list[1]!)
//    }
//
//    func isPalindrome() {
//        //P06 (*) Find out whether a linked list is a palindrome.
//        guard let palendrome = palendrome else {return}
//        guard let list = listOne else {return}
//        let isPalendrome = palendrome.isPalindrome()
//        let isNotPalindrome = list.isPalindrome()
//        print(isPalendrome)
//        print(isNotPalindrome)
//    }
//
//}
