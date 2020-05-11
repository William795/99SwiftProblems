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

//My own extension for printing the values of an entire list so I can more easialy fix bugs/troubleshoot
extension List {
    func printList() {
        var mutatableList = self
        print(mutatableList.value)
        while mutatableList.next != nil {
            mutatableList = mutatableList.next!
            print(mutatableList.value)
        }
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

//P 13 Run-length encoding of a linked list (direct solution).
// basically problems 9 & 10 in one function
extension List where T: Equatable {
    func encodeDirect() -> List<(Int, T)> {
        // 3 variables - the original list / the list to return / my counter of duplicates
        var mutatableList = self
        var directEncodedList = List<(Int, T)>()
        var numberOfDuplicates = 0
        //while loop to go through the list
        while mutatableList.value != nil {
            //increment the duplicate counter
            numberOfDuplicates += 1
            //if the next value dose not equal the current (AKA not a duplicate) do this
            if mutatableList.value != mutatableList.next?.value {
                // 2 variables - the (Int, T) pair that I need to fill my returning list with / temparary list for adding onto the returning List
                let IntTPair = (numberOfDuplicates, mutatableList.value)
                let newList = List<(Int, T)>(IntTPair)
                //populating the directEncodedList in reverse order
                newList?.next = directEncodedList
                directEncodedList = newList
                //reset the duplicate counter
                numberOfDuplicates = 0
            }
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        // reversing the list to put it back in proper order
        return directEncodedList!.reverse()
    }
}

//P 14 Duplicate the elements of a linked list.
// (a, b, c) -> (a, a, b, b, c, c)
extension List {
    func duplicate() -> List {
        // original list and list to return
        var mutatableList = self
        var duplicatedList = List()
        //while loop to go through the original list
        while mutatableList.value != nil {
            //adding mutatableList's value to the duplicatedList twice
            for _ in 0...1 {
                let newList = List(mutatableList.value)
                newList?.next = duplicatedList
                duplicatedList = newList
            }
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        //reversing the reversed order the duplicatedList is in
        return duplicatedList!.reverse()
    }
}

//P 15 Duplicate the elements of a linked list a given number of times.
extension List {
    func duplicate(times: Int) -> List {
        // original list and list to return
        var mutatableList = self
        var duplicatedList = List()
        //while loop to go through the original list
        while mutatableList.value != nil {
            //adding mutatableList's value to the duplicatedList based on the times variable
            for _ in 1...times {
                let newList = List(mutatableList.value)
                newList?.next = duplicatedList
                duplicatedList = newList
            }
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        //reversing the reversed order the duplicatedList is in
        return duplicatedList!.reverse()
    }
}

//P 16 Drop every Nth element from a linked list
extension List {
    func drop(every: Int) -> List? {
        // original list and list to return
        var mutatableList = self
        var droppedList = List()
        //var to keep track of when to drop a value
        var dropCounter = 0
        //while loop to go through the original list
        while mutatableList.value != nil {
            //increment the drop counter
            dropCounter += 1
            //if drop not hit yet
            if dropCounter != every {
                //add value to list to return
                let newList = List(mutatableList.value)
                newList?.next = droppedList
                droppedList = newList
            } else {
                //if drop hit reset drop counter and move on
                dropCounter = 0
            }
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        //reversing the reversed order the droppedList is in
        return droppedList?.reverse()
    }
}

//P 17 Split a linked list into two parts.
extension List {
    func split(atIndex: Int) -> (left: List, right: List) {
        //variables for original list / leftSide / rightSide
        var mutatableList = self
        var leftList = List(mutatableList.value)
        var rightList = List()
        //loop counter to determine when to split (starts at 1 due to left side starting with a value)
        var loopCount = 1
        //while mutatableList has another value, loop
        while mutatableList.next != nil {
            //increment to next value
            mutatableList = mutatableList.next!
            //increment loop counter
            loopCount += 1
            //defines newList before the if statement (to save from writing it twice)
            let newList = List(mutatableList.value)
            //if loop counter is below the specified index
            if loopCount <= atIndex {
                //add the value to the left list
                newList?.next = leftList
                leftList = newList
            } else {
                //else add it to the right
                newList?.next = rightList
                rightList = newList
            }
        }
        //return the lists reversed (due to how adding values to linkedLists(or at least this one in the manner that I am doing so) reverses the order of said values))
        return (leftList!.reverse(), rightList!.reverse())
    }
}
// Note: due to leftside starting with a value calling a split at index of 1 or 0 gives the same result

//P 18 Extract a slice from a linked list.
extension List {
    func slice(from: Int, _ to: Int) -> List {
        //var for self / list to return
        var mutatableList = self
        var listSlice = List()
        //var to keep track of loop count
        var loopCount = 0
        //while mutatableList has another value, loop
        while mutatableList.value != nil {
            //increment loop count
            loopCount += 1
            //if loop count is between specified int values add the values to the return list
            if from < loopCount && loopCount <= to {
                let newList = List(mutatableList.value)
                newList?.next = listSlice
                listSlice = newList
            }
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        //return the list and reverse it to put back in proper order
        return listSlice!.reverse()
    }
}

//P 19 Rotate a list N places to the left.
// (1, 2, 3, 4) -> rotate(1) -> (2, 3, 4, 1) / rotate(-1) -> (4, 1, 2, 3)
extension List {
    func rotate(amount: Int) -> List {
        // 3 list variables : current list / the list being returned / the list to hold the values that I want to add to the list ,i'm returning, at a different point
        var mutatableList = self
        var rotatedList = List()
        var holdingList = List()
        //modifiedAmount is for negative imput values
        let modifiedAmount = amount + self.length
        //counting loops
        var loopCount = 0
        //while mutatableList has another value, loop
        while mutatableList.value != nil {
            //increment loop count
            loopCount += 1
            //declareing newList here instead of in 4 places down below
            let newList = List(mutatableList.value)
            //if amount is positive
            if amount >= 0 {
                // add the first (amount) values to the holdingList
                if loopCount <= amount {
                    newList?.next = holdingList
                    holdingList = newList
                } else {
                    //put the rest in the rotatedList
                    newList?.next = rotatedList
                    rotatedList = newList
                }
                //if amount is negative
            } else {
                // add all but the last (|amount|) of values to the rotatedList
                if loopCount <= modifiedAmount {
                    newList?.next = rotatedList
                    rotatedList = newList
                } else {
                    //puts the rest in the holdingList
                    newList?.next = holdingList
                    holdingList = newList
                }
            }
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            //reverse different lists based on whether (amount) is positive or negative
            if amount >= 0 {
                holdingList = holdingList?.reverse()
            } else {
                rotatedList = rotatedList?.reverse()
            }
            //loop through the holdingList to add the values to the rotatedList
            while holdingList?.value != nil {
                let newList = List(holdingList!.value)
                newList?.next = rotatedList
                rotatedList = newList
                // moves the holdingList forward and breaks the loop in there is no next value
                if holdingList?.next != nil {
                    holdingList = holdingList?.next!
                    continue
                }
                break
            }
            break
        }
        // determines whether to reverse the rotatedList based on if (amount) is positive or negative
        return amount >= 0 ? rotatedList!.reverse() : rotatedList!
    }
}
//Oh boy is this a mess I think this is about O(n * 4) which is technically still O(n) but in its current state it is probably my most inefficent and messy function thus far.
//definately the hardest problem so far (the last 5 or so were all sub 20min cake walks while this one took about 2 hours)

//P 20 Remove the Kth element from a linked list. - list.removeAt(1) (1, 2, 3, 4) -> ((1, 3, 4), 2)
extension List {
    func removeAt(position: Int) -> (rest: List?, removed: T?) {
        //variables for... list to get information from / list to populate the 'rest'value / tuple to return
        var mutatableList = self
        var theRestList = List()
        var returnTuple: (List<T>?, T?)
        //loop counter to know how far down the main list I am
        var loopCount = 0
        //while mutatableList has another value, loop
        while mutatableList.value != nil {
            //if i'm not at the correct position add the current value to the 'rest' list
            if loopCount != position {
                let newList = List(mutatableList.value)
                newList?.next = theRestList
                theRestList = newList
            } else {
                //if I am populate the tuple T?
                returnTuple.1 = mutatableList.value
            }
            //increment loop count
            loopCount += 1
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            //set the tuple List? (also the list is backwards so it needs to be reversed)
            returnTuple.0 = theRestList?.reverse()
            break
        }
        return returnTuple
    }
}

//P 21 Insert an element at a given position into a linked list.
//(1,2,3) -> insert(index: 1, value: 5) -> (1, 5, 2, 3)
extension List {
    func insertAt(index: Int, _ value: T) {
        //variables for... list to get information from / list to set self to
        var mutatableList = self
        var insertedList = List()
        //loop counter to know how far down the main list I am
        var loopCount = 0
        //while mutatableList has another value, loop
        while mutatableList.value != nil {
            //if at index point
            if loopCount == index {
                // add 'value' to insertedList
                let newList = List(value)
                newList?.next = insertedList
                insertedList = newList
            }
            //add mutatableList value to insertedList
            let newList = List(mutatableList.value)
            newList?.next = insertedList
            insertedList = newList
            //increment loop count
            loopCount += 1
            // moves the mutatableList forward and breaks the loop in there is no next value
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        //reverse the backwards insertedList
        insertedList = insertedList?.reverse()
        //set self to insertedList
        self.value = insertedList?.value ?? value
        self.next = insertedList?.next
    }
}

//P 22 Create a linked list containing all integers within a given range.
extension List {
    class func range(from: Int, _ to: Int) -> List<Int> {
        //list to return
        var rangeList = List<Int>()
        //add all intergers from the given range to the list
        for i in from...to {
            let newList = List<Int>(i)
            newList?.next = rangeList
            rangeList = newList
        }
        //return the list reversed to proper order
        return rangeList!.reverse()
    }
}

//P 23 Extract a given number of randomly selected elements from a linked list.
extension List {
    func randomSelect(amount: Int) -> List {
        //basic starting variables
        var mutatableList = self
        var randomList = List()
        //var to keep track of mutatableList Length
        var mutatableListLength = mutatableList.length
        //loop (amount) times
        for _ in 1...amount {
            // get a random Int between 0 and mutatableList's length
            let randomInt = Int.random(in: 0...mutatableListLength - 1)
            // removing a value based off the random number
            let tuple = mutatableList.removeAt(position: randomInt)
            //deincrement muta's length
            mutatableListLength -= 1
            //add the value removed to the list being returned
            let newList = List(tuple.1!)
            newList?.next = randomList
            randomList = newList
            //if statement to not crash if amount is set higher than list length
            if tuple.0 != nil {
                // set mutatableList = to itself minus the element that corrisponds to the random number
                mutatableList = tuple.0!
            }
        }
        //return the list not reversed because the list is already in random order
        return randomList!
    }
}

//P 24 Lotto: Draw N different random numbers from the set 1..M.
extension List {
    class func lotto(numbers: Int, _ maximum: Int) -> List<Int> {
        //List to return
        var lottoList = List<Int>()
        //loop 5 times
        for _ in 1...5 {
            //get random Int between the specified Int values
            let randomInt = Int.random(in: numbers...maximum)
            //add Int to lottoList
            let newList = List<Int>(randomInt)
            newList?.next = lottoList
            lottoList = newList
        }
        return lottoList!
    }
}

//P 25 Generate a random permutation of the elements of a linked list.
// (1, 2, 3, 4, 5) -> (3, 1, 5, 2, 4) or somthing
extension List {
    //just running P23 solution with amount = list length
    func randomPermute() -> List {
        let listLength = self.length
        let permutedList = self.randomSelect(amount: listLength)
        return permutedList
    }
}
//very easy, tho I did need to rework P 23 a little

//P 26 Generate the combinations of K distinct objects chosen from the N elements of a linked list.
extension List {
    func combinations(group: Int) -> List<List<T>> {
        var mutatableList = self
        var combinationsList = List<List<T>>()
        let baseListlength = self.length
        //what do I need?
        //loop through muta list
        while mutatableList.next != nil {
            var mutatableNext = mutatableList.next
            var testList = List(mutatableList.value)

            var combineHelpList = combineHelper(staticList: testList!, loopingList: mutatableNext!)
            for _ in (1...combineHelpList.length) {
                let newList = List<List<T>>(combineHelpList.value)
                newList?.next = combinationsList
                combinationsList = newList
                if combineHelpList.next != nil {
                    combineHelpList = combineHelpList.next!
                } else {
                    break
                }
            }
            
            
            
            // loop other two based on group size
            //loop to the end of list
//            for _ in (1...baseListlength) {
//            }
            // for making a list (group) size
//            for _ in (1...group) {
//            }
            //make groups
            //- need to grab the first (group) values
            //- cycle through the list keeping the first (group - 1) values
            //add groups to com list
            //repeat for (group - 2)... (group - group)
            //end loop
            
            
            
            
            
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        return combinationsList!.reverse()
    }
    // should make a bunch of lists which contain (staticList + single loopingList value) and returns them all in a List of Lists
    private func combineHelper(staticList: List, loopingList: List) -> List<List<T>> {
        var mutatableList = loopingList
        var returnList = List<List<T>>()
        
        while mutatableList.value != nil {
            
            let mutaStaticList = List(mutatableList.value)
            mutaStaticList?.next = staticList.reverse()
            
            let listList = List<List<T>>(mutaStaticList!.reverse())
            listList?.next = returnList
            returnList = listList
            
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        return returnList!.reverse()
    }
}
