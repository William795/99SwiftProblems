//
//  LinkedList2.swift
//  99SwiftProblems
//
//  Created by William Moody on 4/3/20.
//  Copyright © 2020 William Moody. All rights reserved.
//

import Foundation

//Coming back and plan to redo everything and come up with solutions to problems that I skipped/looked up/did poorly.
//As a result this will probably be worse code is some places but I plan to keep everything to at least under O(n)^2 and hopefully keep things in O(n) or better

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
                // ToDo - remove the need for this if statement
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

//P 08 Eliminate consecutive duplicates of linked list elements

extension List where T: Equatable {
    func compress() -> List{
        //current list and the list to return
        var mutatableList = self
        var compressedList = List(value)
        
        //while loop to go through the entire list
        while mutatableList.next != nil {
            //cycle methood through the list
            mutatableList = mutatableList.next!
            //check to see if there is a duplicate
            if mutatableList.value != compressedList?.value {
                //adding nonduplicates to the list
                let newList = List(mutatableList.value)
                newList?.next = compressedList
                compressedList = newList
            }
        }
        //returning the reversed compressed list because the methood used to add nonduplicates reverses the placement
        return compressedList!.reverse()
    }
}

//P 09 Pack consecutive duplicates of linked list elements into sub linked lists.

//not very familiar with how <>'s work so this is largely a solution found through messy trial and error
extension List where T: Equatable {
    func pack() -> List<List<T>> {
        //current list, list to hold duplicates, and the list to return
        var mutatableList = self
        var compressedList = List(value)
        var packedList: List<List<T>>? = List<List>()
        
        //while loop to go through the entire list
        while mutatableList.next != nil {
            //cycle methood through the list
            mutatableList = mutatableList.next!
            //check to see if there is a duplicate
            if mutatableList.value == compressedList?.value {
                //adding duplicates to the list
                let newList = List(mutatableList.value)
                newList?.next = compressedList
                compressedList = newList
                
                //if statement here to make sure the last set of duplicates don't get skipped
                if mutatableList.next == nil {
                    let tempList: List<List<T>> = List<List>(self)!
                    tempList.value = compressedList!
                    tempList.next = packedList
                    packedList = tempList
                    compressedList = List()
                }
            } else {
                //self is in the tempList to not crash the app otherwise the same methood of adding items to lists that I have used everywhere else
                let tempList: List<List<T>> = List<List>(self)!
                tempList.value = compressedList!
                tempList.next = packedList
                packedList = tempList
                //resetting compressedList's values
                compressedList = List()
                
                //catches nonduplicates in the original List
                let newList = List(mutatableList.value)
                newList?.next = compressedList
                compressedList = newList
            }
        }
        //list gets reversed as I process it so I need to reverse is again before returning it
        return packedList!.reverse()
    }
}

//P 10 Run-length encoding of a linked list

extension List where T: Equatable {
    func encode() -> List<(Int, T)> {
        // first value is the result of the pack function above
        var mutatablePackedList = self.pack()
        //second value is the template for the returned list values
        var intValuePair = (1, value)
        //third value is what this function returns
        var encodedList: List<(Int, T)>? = List<(Int, T)>.init()
        
        while mutatablePackedList.value != nil {
            //fixing values to the intValuePair
            let numberOfDuplicates = mutatablePackedList.value.length
            intValuePair.0 = numberOfDuplicates
            intValuePair.1 = mutatablePackedList.value.value
            //adding the intValuePair onto the encodedList (in reverse order)
            let newList = List<(Int, T)>(intValuePair)
            newList?.next = encodedList
            encodedList = newList

            if mutatablePackedList.next != nil {
                //cycle through the packedList
                mutatablePackedList = mutatablePackedList.next!
                continue
            }
            break
        }
        // returning the encodedList in reverse order to put it back straight
        return encodedList!.reverse()
    }
}

//P 11 Modified run-length encoding

extension List where T: Equatable {
    func encodeModified() -> List<Any> {
        // the list i'm mutating and returning
        var mutatableList = self.encode()
        var modifiedEncodedList: List<Any>?
        //same while loop as all the others
        while mutatableList.value != nil {
            // checking if there are no duplicates for the current value
            if mutatableList.value.0 == 1 {
                //if there are no duplicates I just add the value by itself
                let newList: List<Any> = List<Any>(mutatableList.value.1)!
                newList.next = modifiedEncodedList
                modifiedEncodedList = newList
            } else {
                //else I add the entire (Int, T) pair to the list
                let newList = List<Any>(mutatableList.value)
                newList?.next = modifiedEncodedList
                modifiedEncodedList = newList
            }
            //check if the list is at the end
            if mutatableList.next != nil {
                //if not move the list down the chain and continue
                mutatableList = mutatableList.next!
                continue
            }
            //if so break the loop
            break
        }
        // return the list reversed for the same reason as the others
        return modifiedEncodedList!.reverse()
    }
}

//P 12 Decode a run-length encoded linked list.
//solving for strings only
//Decoding the 'output' of P 10
extension List {
    func decode() -> List<String> {
        //error message and guard statement in case a non List<(Int, String)> goes through this function
        let errorList = List<String>("non decodable list entered into decode function")
        guard var mutatableList: List<(Int, String)> = self as? List<(Int, String)> else { return errorList! }
        // list that is being returned
        var decodedList = List<String>()
        //same while loop as all the others
        while mutatableList.value != nil {
            //for loop that adds the string values to the decodedList based on the Int value
            for _ in 1...mutatableList.value.0 {
                let newList = List<String>(mutatableList.value.1)
                newList?.next = decodedList
                decodedList = newList
            }
            
            //same end as the other while loops that can't easily skip the first value of the original List
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        //adding to the List is backwards so I return the reversed decodedList
        return decodedList!.reverse()
    }
}
