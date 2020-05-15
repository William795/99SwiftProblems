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
    var listTwo = List("a", "b", "c", "c", "d")
    var palendrome = List(1, 2, 3, 3, 2, 1)
    var nestedList = List<Any>(List<Any>(1, 1)!, 2, List<Any>(3, List<Any>(5, 8)!)!)
    var duplicateList = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    let encodedList = List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e"))
    let smallList = List(1, 2, 3, 4, 5, 6)
    
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
    
    //P 11
    func printModifiedEncode() {
        let modEncodedList = duplicateList?.encodeModified()
        print(modEncodedList?.length as Any)
        print(modEncodedList?.value as Any)
        print(modEncodedList?.next?.value as Any)
        print(modEncodedList?.last as Any)
    }
    
    //P 12
    func printDecodedList() {
        print(listOne?.decode().value as Any)
        let decodedList = encodedList?.decode()
        print(decodedList?.length as Any)
        print(decodedList?.value as Any)
        print(decodedList?.next?.value as Any)
        print(decodedList?.next?.next?.next?.next?.value as Any)
        print(decodedList?.last as Any)
        
    }
    
    //P 13
    func printDirectEncodedList() {
        let DirectEncodedList = duplicateList?.encodeDirect()
        print(DirectEncodedList?.length as Any)
        print(DirectEncodedList?.value as Any)
        print(DirectEncodedList?.next?.value as Any)
        print(DirectEncodedList?.last as Any)
        print(DirectEncodedList?.next?.next?.value as Any)
        print(DirectEncodedList?.next?.next?.next?.value as Any)
        print(DirectEncodedList?.next?.next?.next?.next?.value as Any)
    }
    
    //P 14
    func printDuplicatedList() {
        let duplicatedList = listTwo?.duplicate()
        print(duplicatedList?.length as Any)
        print(duplicatedList?.value as Any)
        print(duplicatedList?.next?.value as Any)
        print(duplicatedList?.last as Any)
        print(duplicatedList?.next?.next?.value as Any)
        print(duplicatedList?.next?.next?.next?.value as Any)
        print(duplicatedList?.next?.next?.next?.next?.value as Any)
    }
    
    //P 15
    func printDuplicateXTimesList() {
        let duplicateFourTimesList = listTwo?.duplicate(times: 4)
        print(duplicateFourTimesList?.length as Any)
        print(duplicateFourTimesList?.value as Any)
        print(duplicateFourTimesList?.next?.value as Any)
        print(duplicateFourTimesList?.last as Any)
        print(duplicateFourTimesList?.next?.next?.value as Any)
        print(duplicateFourTimesList?.next?.next?.next?.value as Any)
        print(duplicateFourTimesList?.next?.next?.next?.next?.value as Any)
    }
    
    //P 16
    func printDroppedNthElementList() {
        let drop3List = duplicateList?.drop(every: 3)
        print(drop3List?.length as Any)
        print(drop3List?.value as Any)
        print(drop3List?.next?.value as Any)
        print(drop3List?.next?.next?.value as Any)
        print(drop3List?.next?.next?.next?.value as Any)
        print(drop3List?.next?.next?.next?.next?.value as Any)
        print(drop3List?.last as Any)
    }
    
    //P 17
    func printSplitList() {
        let splitTuple = listOne?.split(atIndex: 5)
        print(splitTuple?.left.value as Any)
        print(splitTuple?.left.length as Any)
        print(splitTuple?.left.last as Any)
        print(splitTuple?.right.value as Any)
        print(splitTuple?.right.length as Any)
        print(splitTuple?.right.last as Any)
    }
    
    //P 18
    func printListSlice() {
        let slicedList = listOne?.slice(from: 3, 7)
        print(slicedList?.length as Any)
        print(slicedList?.value as Any)
        print(slicedList?.next?.value as Any)
        print(slicedList?.last as Any)
    }
    
    //P 19
    func printRotatedList() {
        let rotatedListForward = listOne?.rotate(amount: 4)
        print("list 1")
        rotatedListForward?.printList()
        let rotatedListBack = listOne?.rotate(amount: -4)
        print("list 2")
        rotatedListBack?.printList()
    }
    
    //P 20
    func printRemoveKthElementTuple() {
        let removeAt2List = listOne?.removeAt(position: 1)
        print(removeAt2List?.1)
        removeAt2List?.0?.printList()
    }
    
    //P21
    func printInsertAtList() {
        let insertAtList = listOne
        insertAtList?.insertAt(index: 4, 10)
        insertAtList?.printList()
    }
    
    //P 22
    func printRangeList() {
        let rangeList = List<Any>.range(from: 2, 10)
        rangeList.printList()
    }
    
    //P 23
    func extractRandomElements() {
        let randomExtractedElementsList = listOne?.randomSelect(amount: 5)
        randomExtractedElementsList?.printList()
    }
    
    //P 24
    func printLotto() {
        let lotto = List<Any>.lotto(numbers: 1, 100)
        lotto.printList()
    }
    
    //P 25
    func printPermutationList() {
        let permutationList = palendrome?.randomPermute()
        permutationList?.printList()
    }
    
    //P 26
    func printCombinationList() {
        print("list 1")
        let combinationList = smallList?.combinations(group: 2)
        print(combinationList?.length as Any)
        combinationList?.printEmbeddedList()
        print("list2")
        let combinationList2 = smallList?.combinations(group: 3)
        print(combinationList2?.length as Any)
        combinationList2?.printEmbeddedList()
        print("list3")
        let combinationList3 = smallList?.combinations(group: 4)
        print(combinationList3?.length as Any)
        combinationList3?.printEmbeddedList()
    }
}
