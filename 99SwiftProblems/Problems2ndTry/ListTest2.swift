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
    var duplicateList = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    
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
    
    //P 06
    func printPalindromCheck() {
        print(listOne?.isPalindrome() as Any)
        print(palendrome?.isPalindrome() as Any)
    }
    
    //P 07
    func printFlattenNestedLinkedListStructure() {
        let flatList = nestedList?.flatten()
        print(flatList?.value as Any)
        print(flatList?.pennultimate as Any)
        print(flatList?.next?.value as Any)
        print(flatList?.length as Any)
        print(flatList?.last as Any)
    }
    
    //P 08
    func printCompressedList() {
        print(duplicateList?.compress().length as Any)
        print(duplicateList?.compress().value as Any)
    }
    
    //P 09
    func printPackedList() {
        let packedList = duplicateList?.pack()
        print(packedList?.length as Any)
        print(packedList?.value.value as Any)
        print(packedList?.value.length as Any)
        print(packedList?.next?.value.value as Any)
        print(packedList?.next?.value.length as Any)
        print(packedList?.last?.value as Any)
        print(packedList?.last?.length as Any)
    }
    
    //P 10
    func printEncode() {
        let encodedList = duplicateList?.encode()
        print(encodedList?.length as Any)
        print(encodedList?.value as Any)
        print(encodedList?.next?.value as Any)
        print(encodedList?.last as Any)
    }
    
    func printModifiedEncode() {
        let modEncodedList = duplicateList?.encodeModified()
        print(modEncodedList?.length as Any)
        print(modEncodedList?.value as Any)
        print(modEncodedList?.next?.value as Any)
        print(modEncodedList?.last as Any)
    }
}
