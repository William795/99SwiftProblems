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
        var lastValue = self.value
        let list = next
        lastValue = list?.last ?? value
        return lastValue
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
    //function to take the output of flattenInReverse and reverse it so that the List is in the correct order
    func flatten() -> List {
        
        let reversedFlattenedList = self.flattenInReverse()
        return reversedFlattenedList.reverse()
    }
    
    private func flattenInReverse() -> List {
        //three variables to allow me to manipulate the information...
        //the current List
        var mutatableList = self
        //the List I will return
        var flattenedList = List()
        //the/a List within the current List
        var embeddedList = List()
        
        //the loop to go through the entire mutatable List
        while mutatableList.value != nil  {
            //check if current value is a List
            guard let nestedList = mutatableList.value as? List<Any> else {
                //if not add item to flattenedList (however this reverses the List)
                let newList = List(mutatableList.value)
                newList?.next = flattenedList
                flattenedList = newList
                
                //if statement to check if there is another value in the mutatable List
                //(This is skipped in the reverse/isPalindrome functions because they both get around needing the first value in the List (reverse by throwing it into the return value at the start, and palindrome by the fact that the last check is the same as the first))
                if mutatableList.next != nil {
                    mutatableList = mutatableList.next!
                    continue
                }
                return flattenedList!
            }
            // if current value is a list use recurssion
            embeddedList = nestedList.flattenInReverse() as? List<T>
            // The List comes out backwards so it needs to be reversed
            embeddedList = embeddedList?.reverse()
            //same while loop as above, just with the values of a embedded List
            while embeddedList?.value != nil {
                let newList = List(embeddedList!.value)
                newList?.next = flattenedList
                flattenedList = newList
                //embeddedList's value can be nil because nothing is requiring a value there so I can use an optional instead of an if statement
                embeddedList = embeddedList?.next
            }
            //same as above
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            return flattenedList!
        }
        print("somthing went very wrong in the flatten function")
        //here to silence red warnings
        return flattenedList!
    }
}
