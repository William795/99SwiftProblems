//
//  LinkedList2.swift
//  99SwiftProblems
//
//  Created by William Moody on 4/3/20.
//  Copyright © 2020 William Moody. All rights reserved.
//

import Foundation

//Coming back and plan to redo everything and come up with solutions to problems that I skipped/looked up
//as a result this will probably be worse code overall but hopefully it will help me learn somthing

class List<T> {
    var value: T
    var next: List<T>?
    
    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init?(_ values: [T]) {
        guard let first = values.first else { return nil }
        value = first
        next = List(Array(values.suffix(from: 1)))
    }
}

//P01 Find the last element of a Linked List
// TODO - maybe come up with a different solution - This solution turns every value in the list into the last value - 1, 2, 3, 4 -> 4, 4, 4, 4,
extension List {
    var last: T? {
        value = next?.last ?? value
        return value
    }
}

//P 02 Find the last but one element of a linked list (Pennultimate)

extension List {
    var pennultimate: T? {
        guard let next = next else { return nil }
        return next.pennultimate ?? value
    }
}

//P 03 Find the Kth element of a Linked list

extension List {
    subscript(index: Int) -> T? {
        return index == 0 ? value : next?[index - 1]
    }
}

//P 04 Find the number of elements of a Linked List

extension List {
    var length: Int {
        return 1 + (next?.length ?? 0)
    }
}

//P 05 Reverse a Linked List

extension List {
    func reverse() -> List {
        // Original list to mutate
        var mutatableList = self
        // List to return (which already contains the first value of the original List)
        var reverseList = List(value)
        
        while mutatableList.next != nil {
            // Removing the current value from the list to cycle through the entire list
            mutatableList = mutatableList.next!
            // Making a new list to store current mutatable list value
            let newList = List([mutatableList.value])
            // Making newList.next = to the reverse list (which pushes everything in the reverseList down one position
            newList?.next = reverseList
            // setting reverseList to newList to 'save' what has been done
            reverseList = newList
        }
        return reverseList!
    }
}

//P 06 find if a Linked List is a palindrome

extension List where T:Equatable {
    func isPalindrome() -> Bool {
        //creates two lists for comparison
        var currentList = self
        var reversedList = self.reverse()
        
        while currentList.next != nil {
            //stepping to the next value in the list for both Lists to continue the comparison (don't need to worry about the first comparison because it is the same as the last)
            currentList = currentList.next!
            reversedList = reversedList.next!
            // if statement to return false if the list is not a palindrome
            if currentList.value != reversedList.value {
                return false
            }
        }
        //If the while loop above does not return false or crash this funcion will return true
        return true
    }
}

//P 07 Flatten a nested Linked List structure

extension List {
    func flatten() -> List {
        
        var mutatableList = self
        var flattenedList = List()
        var list = List()
        
        while mutatableList.value != nil  {
            print("start of while 1")
            guard let nestedList = mutatableList.value as? List<Any> else {
                
                let newList = List(mutatableList.value)
                newList?.next = flattenedList
                flattenedList = newList
                
                if mutatableList.next != nil {
                    mutatableList = mutatableList.next!
                    continue
                }
                return flattenedList!
            }
            list = nestedList.flatten() as? List<T>
//            list = nestedList as! List<T>
            while list?.value != nil {
                print("start of while 2")
                let newList = List(list!.value)
                newList?.next = flattenedList
                flattenedList = newList
                list = list?.next
            }
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            return flattenedList!
        }
        return flattenedList!.reverse()
    }
}
