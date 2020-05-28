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

//My own extensions for printing the values of an entire list so I can more easialy fix bugs/troubleshoot
extension List {
    func printList() {
        var mutatableList = self
        print(mutatableList.value)
        while mutatableList.next != nil {
            mutatableList = mutatableList.next!
            print(mutatableList.value)
        }
        print("end list")
    }
}
extension List {
    func printEmbeddedList() {
        var mutatableList = self
        while mutatableList.value != nil {
            //change the List type based on what list it will be recieving
            var nestedList = mutatableList.value as? List<String>
            print(nestedList?.value as Any)
            while nestedList?.next != nil {
                nestedList = nestedList?.next!
                print(nestedList?.value as Any)
            }
            print("list end")
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
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
            //add mutatableList value to insertedList
            let newList = List(mutatableList.value)
            newList?.next = insertedList
            insertedList = newList
            //increment loop count
            loopCount += 1
            //if at index point
            if loopCount == index {
                // add 'value' to insertedList
                let newList = List(value)
                newList?.next = insertedList
                insertedList = newList
            }
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
//  List("a", "b", "c").combinations(2) -> List(List("a", "b"), List("a", "c"), List("b", "c"))
extension List {
    func combinations(group: Int) -> List<List<T>> {
        // built all funtionallity in a seperate private function
        // Also reversed to get it in the proper order
        return generateBinomialCoeffecient(list: self, groupSize: group, loopLevel: group, staticValueList: nil )!.reverse()
    }
    // seperate function for ease of information manipulation
    private func generateBinomialCoeffecient(list: List, groupSize: Int, loopLevel: Int, staticValueList: List?) -> List<List<T>>? {
        // variables for
        // mutatableList (main list i'm working with)
        var mutatableList = list
        // returnList (list that i'm returning)
        var returnList = List<List<T>>()
        // staticList (list that holds the 'static' variables gathered from recusion )
        var staticList = staticValueList
        // loop through the main list length to ensure every value goes through the process
        for _ in 1...list.length {
            // check to see if it is the first iteration of the function
            if loopLevel == groupSize {
                // setting staticList to a list holding the current mutatableList.value
                staticList = List(mutatableList.value)!
                // check for wether the current function iteration is not the first or last
            } else if loopLevel > 1 {
                //reset staticList
                staticList = staticValueList?.reverse()
                // set staticList's last value to mutatableList.value
                let newList = List(mutatableList.value)
                newList?.next = staticList
                staticList = newList?.reverse()
            }
            // check to make sure the current function iteration is not the last
            if loopLevel > 1 {
                // safety for crashing
                if mutatableList.next == nil {
                    break
                }
                // call function again with an updated list, loopLevel, and staticList
                let listOfLists = generateBinomialCoeffecient(list: mutatableList.next!, groupSize: groupSize, loopLevel: loopLevel - 1, staticValueList: staticList!)?.reverse()
                // check for weather the above call returned somthing
                if listOfLists?.value != nil {
                    // if so add the new items to the returnList
                    returnList = combineListsOfLists(listOne: returnList, listTwo: listOfLists!)
                }
            } else {
                // if the current function iteration is the last one...
                // make a list from mutatableList.value and the staticList
                let newList = List(mutatableList.value)
                newList?.next = staticList?.reverse()
                // make a list of lists from newList list and add it to the returnList
                let newListOfLists = List<List<T>>(newList!.reverse())
                newListOfLists?.next = returnList
                returnList = newListOfLists
            }
            // increment the mutatableList forward 1
            if mutatableList.next != nil {
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        return returnList
    }
    
    // a function made when I was combining Lists of Lists in like 4+ places. Just keeping it because i'm using it once in the above funtion
    // function that does what it's name implies
    private func combineListsOfLists(listOne: List<List<T>>?, listTwo: List<List<T>>) ->List<List<T>> {
        var returnList = listOne
        var mutatableListTwo = listTwo
        for _ in (1...mutatableListTwo.length) {
            let newList = List<List<T>>(mutatableListTwo.value)
            newList?.next = returnList
            returnList = newList!
            if mutatableListTwo.next != nil {
                mutatableListTwo = mutatableListTwo.next!
            }
        }
        return returnList!
    }
}
// OHHH Boy this problem was a doozy of a problem
// Took 7 days of coding for 2-3 hours each to solve for a total of somewhere around 15+ hours in total
// This solution was the cullmination of 4-5 different failed functions, 3 different complete rewrites, deciding to scrap almost everything, a new helper function (printEmbeddedList), and more than 200 lines of deleted code.
// The main thing that was giving me issues was figuring our how to properly go through the list.
// I quickly put together a solution that would solve groups of 2, but I did it with basic loops and in order to do a group of 3 I would need to throw everything I had into another loop but then I would need another loop for groups of 4 and so on...
// I quickly came to the realization that I needed to loop things based off of the group number and threw together another solution that could solve 2's and 3's but would miss a few things in 4's onwords
// For example in a list of 1,2,3,4,5,6 I would get everything except 1,3,5,6.
//So then I decided to go for recursion (which I really should have done from the start but I didn't because I don't have much experiance with recursion in general and feel much more comfortable with loops and stuff) and came to the solution you see above over 2 1/2 days

//P 26B Generate the permutations of K distinct objects chosen from the N elements of a linked list.
// List("a", "b", "c").permutations(2) -> List(List("a", "b"), List("a", "c"), List("b", "a"), List("b", "c"), List("c", "a"), List("c", "b"))
extension List {
    func permutations(group: Int) -> List<List<T>> {
        
        return generateAllPermutationsOf(list: self, groupSize: group, loopLevel: group, staticValueList: nil)!.reverse()
    }
    
    private func generateAllPermutationsOf(list: List, groupSize: Int, loopLevel: Int, staticValueList: List?) -> List<List<T>>? {
           // variables for
           // mutatableList (main list i'm working with)
           var mutatableList = list
           // returnList (list that i'm returning)
           var returnList = List<List<T>>()
           // staticList (list that holds the 'static' variables gathered from recusion )
           var staticList = staticValueList
           // loop through the main list length to ensure every value goes through the process
           for _ in 1...list.length {
               // check to see if it is the first iteration of the function
               if loopLevel == groupSize {
                   // setting staticList to a list holding the current mutatableList.value
                   staticList = List(mutatableList.value)!
                   // check for wether the current function iteration is not the first or last
               } else if loopLevel > 1 {
                   //reset staticList
                   staticList = staticValueList?.reverse()
                   // set staticList's last value to mutatableList.value
                   let newList = List(mutatableList.value)
                   newList?.next = staticList
                   staticList = newList?.reverse()
               }
               // check to make sure the current function iteration is not the last
               if loopLevel > 1 {
                   // safety for crashing
                   if mutatableList.next == nil {
                       break
                   }
                   // call function again with an updated list, loopLevel, and staticList
                   let listOfLists = generateAllPermutationsOf(list: mutatableList.next!, groupSize: groupSize, loopLevel: loopLevel - 1, staticValueList: staticList!)?.reverse()
                   // check for weather the above call returned somthing
                   if listOfLists?.value != nil {
                       // if so add the new items to the returnList
                       returnList = combineListsOfLists2(listOne: returnList, listTwo: listOfLists!)
                   }
               } else {
                   // if the current function iteration is the last one...
                   // make a list from mutatableList.value and the staticList
                   let newList = List(mutatableList.value)
                   newList?.next = staticList?.reverse()
                   // make a list of lists from newList list and add it to the returnList
                   let newListOfLists = List<List<T>>(newList!.reverse())
                   newListOfLists?.next = returnList
                   returnList = newListOfLists
               }
               // rotate the mutatableList forward 1
               if mutatableList.next != nil {
                mutatableList = mutatableList.rotate(amount: 1)
                   continue
               }
               break
           }
           return returnList
       }
       
       private func combineListsOfLists2(listOne: List<List<T>>?, listTwo: List<List<T>>) ->List<List<T>> {
           var returnList = listOne
           var mutatableListTwo = listTwo
           for _ in (1...mutatableListTwo.length) {
               let newList = List<List<T>>(mutatableListTwo.value)
               newList?.next = returnList
               returnList = newList!
               if mutatableListTwo.next != nil {
                   mutatableListTwo = mutatableListTwo.next!
               }
           }
           return returnList!
       }
}
// This solution is almost entirely copy/pasted from P26 the only thing I changed was how I was incrementing my way through the list,
// In P26 I didn't want the same values to end up in the same list twice e.g.(getting 1,2,3 and 2,1,3) so I just threw mutatableList = mutatableList.next
// In P26B that is exactly what I want so I just replaced the mutatableList = mutatableList.next with mutatableList = mutatableList.rotate(amount: 1) (.rotate from P19 (rotate a list X placesto the right))
// The website says P(12,3) = 660 but a calculator online (and the solution above) gets 1320 so i'm thinking that the guy who made these problems just got his math wrong and am sticking with the above solution
// Due to being able to copy/paste most(just about all) the the solution made this one quite simple and quick, which is a nice break from the brick wall I was banging my head into most of last week

// P 27 Group the elements of a set into disjoint subsets.
// group 9 people to work in 3 disjoint subgroups of 2, 3 and 4 persons
// no permutations of group members so (Aldo, Beat) == (Beat, Aldo) but ((Aldo, Beat), (Carla, David)...) != ((Carla, David), (Aldo, Beat)...)

// TODO make this at least look a little nicer

extension List {
    func group3() -> List<List<List<T>>> {

        var returnList = List<List<List<T>>>()
        var mutatableList = self
        // loop counter for keeping track of where I am in the main list
        var loopCount = 0
        // loop for getting the first value of group 2
        for _ in 1...self.length {
            //using List.removeAt(position) to seperate the values that I am putting into the 2 and 3 groups while keeping the rest of the list intact for making my group of 4
            let removedTouple = self.removeAt(position: loopCount)
            // the part of the list im saving
            let removedToupleList = removedTouple.0
            //mostly just a timer for how long to keep the loop going (tho I am using this value to make group 2)
            var secondMutatableList = mutatableList.next
            //setting aside the first part of Group 2
            let firstTwoValuesList = List(removedTouple.1!)
            // loop counter for keeping track of where I am in the subList
            var loopCount2 = 0
            // loop for getting the second value of group 2 (and calls the function that does the rest)
            for _ in 1...self.length {
                // same touple as above (add the loop counts together to ensure no permutations ie. 1,2 and 2,1)
                let removedTouple2 = removedToupleList?.removeAt(position: loopCount2 + loopCount)
                //setting aside the second value of group 2
                let secondValue = List(secondMutatableList!.value)
                // completing group 2
                firstTwoValuesList?.next = secondValue
                // calls the helper function that does the rest of the work and out puts all the group 3's and group 4's that can go with the current group 2 pair
                var listOfListOfList = setUpSubGroups(subGroupTwo: firstTwoValuesList!, restOfGroup: (removedTouple2?.0)!)
                //adds all group 2,3,4 lists to the return list
                for _ in 1...listOfListOfList.length {
                    let newList = List<List<List<T>>>(listOfListOfList.value)
                    newList?.next = returnList
                    returnList = newList
                    if listOfListOfList.next != nil {
                        listOfListOfList = listOfListOfList.next!
                    }
                }
                //loop break for when secondMutatableList is empty
                if secondMutatableList?.next != nil {
                    secondMutatableList = secondMutatableList?.next
                    loopCount2 += 1
                    continue
                }
                break
            }
            //loop break for when mutatableList is empty
            if mutatableList.next?.next != nil {
                loopCount += 1
                mutatableList = mutatableList.next!
                continue
            }
            break
        }
        return returnList!.reverse()
    }
    
    private func setUpSubGroups(subGroupTwo: List, restOfGroup: List) -> List<List<List<T>>> {
        // all the loops and variables are mostly the same from the above bit with group 2 just with an extra loop to get group 3
        var returnList = List<List<List<T>>>()
        var loopCounter1 = 0
        var mutatableList = restOfGroup
        for _ in 1...restOfGroup.length {
            var secondMutatableList = mutatableList.next
            let removeAtTouple = restOfGroup.removeAt(position: loopCounter1)
            let removeToupleList = removeAtTouple.0
            let firstValue = removeAtTouple.1
            var loopCounter2 = 0
            
            for _ in 1...removeToupleList!.length {
                var thirdMutatableList = secondMutatableList?.next
                let removedAtTouple2 = removeToupleList?.removeAt(position: loopCounter2 + loopCounter1)
                let removeToupleList2 = removedAtTouple2?.0
                let secondValue = secondMutatableList!.value
                var loopCounter3 = 0
                
                for _ in 1...removeToupleList2!.length {
                    let removedAtTouple3 = removeToupleList2?.removeAt(position: loopCounter3 + loopCounter1 + loopCounter2)
                    let groupOfFour = removedAtTouple3?.0
                    let thirdValue = thirdMutatableList!.value
                    let groupOfThree = List(firstValue!, secondValue, thirdValue)
                    //set up the group 2,3,4 list for the current iteration
                    let returnListValue = List<List<T>>(subGroupTwo, groupOfThree!, groupOfFour!)
                    //add it to the return list
                    let returnListSetUp = List<List<List<T>>>(returnListValue!)
                    returnListSetUp?.next = returnList
                    returnList = returnListSetUp
                    if thirdMutatableList?.next != nil {
                        loopCounter3 += 1
                        thirdMutatableList = thirdMutatableList?.next
                        continue
                    }
                    break
                }
                if secondMutatableList?.next?.next != nil {
                    secondMutatableList = secondMutatableList?.next
                    loopCounter2 += 1
                    continue
                }
                break
            }
            if mutatableList.next?.next?.next != nil {
                mutatableList = mutatableList.next!
                loopCounter1 += 1
                continue
            }
            break
        }
        return returnList!.reverse()
    }
}
//Overall its not very pretty or efficent
// there is alot of copy/pasted code here that can be cleaned up, but this problem only took 1 1/2 days instead of more than a week so i'm fairly happy

// P27B Group the elements of a set into disjoint subsets - Part 2
// allow the ability to specify the group sizes
// list.group(List(2, 2, 5))
// List(List(List("Aldo", "Beat"), List("Carla", "David"), List("Evi", "Flip", "Gary", "Hugo", "Ida")), ...)

// This solution will focus on groups that equal 9
// I may do a 27C at some point which will be able to incorperate groups of any size and length
extension List {
    func group(groups: List<Int>) -> List<List<List<T>>>? {
        var returnList = List<List<List<T>>>()
        var mutatableGroups = groups
        var groupValue = groups.value
        // first off I need to make sure the Ints in groups add up to 9
        while mutatableGroups.next != nil {
            mutatableGroups = mutatableGroups.next!
            groupValue += mutatableGroups.value
        }
        if groupValue != 9 {
            return nil
        }
        
        returnList = generateGroupFromSubSets(groupList: groups, remainingValueList: self, recursionLevelTracker: groups.value, staticValueList: nil, groupSubSetList: nil, loopCountModifier: 0)
        
        // To solve this I'm thinking that a modified version of P 26 should work
        // just add some functionallity to keep the entire list as I go through and it should be done (really should have done that in P27)
        // make a func based on Combinations
        // call said func with groups based on the groups list
        //throw the results together and it should be done
        
        return returnList!
    }
    
    private func generateGroupFromSubSets(groupList: List<Int>, remainingValueList: List, recursionLevelTracker: Int, staticValueList: List?, groupSubSetList: List<List<T>>?, loopCountModifier: Int) -> List<List<List<T>>>? {
        var returnList = List<List<List<T>>>()
        var loopCount = 0
        var staticList = staticValueList
        
        for _ in 1...remainingValueList.length {
            // seperates desired value from rest of List
            let removeAtTouple = remainingValueList.removeAt(position: loopCount + loopCountModifier)
            if removeAtTouple.1 == nil {
                return returnList
            }
            // if statement to set up staticList
            //check if its the first function iteration for the group
            if recursionLevelTracker == groupList.value {
                //give staticList a value
                staticList = List(removeAtTouple.1!)
                //check for if its not the last required iteration for the current group
            } else {
                staticList = staticValueList?.reverse()
                let tempList = List(removeAtTouple.1!)
                tempList?.next = staticList
                staticList = tempList?.reverse()
            }
            // check to see if I need to go down another recursion level
            if recursionLevelTracker > 1 {
                // loop through the next value
                var listOfListsOfLists = generateGroupFromSubSets(groupList: groupList, remainingValueList: removeAtTouple.0!, recursionLevelTracker: recursionLevelTracker - 1, staticValueList: staticList, groupSubSetList: groupSubSetList, loopCountModifier: loopCount + loopCountModifier)
                if listOfListsOfLists != nil {
                    for _ in 1...(listOfListsOfLists?.length ?? 1) {
                        let tempAppendList = List<List<List<T>>>(listOfListsOfLists!.value)
                        tempAppendList?.next = returnList
                        returnList = tempAppendList
                        if listOfListsOfLists?.next != nil {
                            listOfListsOfLists = listOfListsOfLists?.next
                            continue
                        }
                        break
                    }
                }
                // if not...
            } else {
                //check to see if it is the second to last group value
                if groupList.next?.next == nil {
                    // check to see if all 3 locations are properly filled
                    if staticList?.length == groupList.value && groupSubSetList != nil {
                        // if all is good then I need to put it all together and return it (number examples from first iteration)
                        // list of list made from removeAtTouple (6,7,8,9) and staticList (3,4,5)
                        let tempAppendingList = List<List<T>>(removeAtTouple.0!, staticList!)
                        // then grap groupSubSetList (1,2)
                        tempAppendingList?.next = groupSubSetList?.reverse()
                        // put them all together in a list of list of list
                        let fullGroupSubSetList = List<List<List<T>>>(tempAppendingList!.reverse())
                        // send it up
                        fullGroupSubSetList?.next = returnList
                        returnList = fullGroupSubSetList
                    }
                } else {
                    // call func again (moving forward the groupList, reseting the recursion tracker, making it loop through the remainder form the touple, and setting the groupSubSetList to the surrent static list )
//                    print("\(groupList.value)")
                    var listOfListsOfLists = generateGroupFromSubSets(groupList: groupList.next!, remainingValueList: removeAtTouple.0!, recursionLevelTracker: groupList.next!.value, staticValueList: nil, groupSubSetList: List<List<T>>(staticList!), loopCountModifier: 0)
                    if listOfListsOfLists != nil {
                        for _ in 1...(listOfListsOfLists?.length ?? 1) {
                            let tempAppendList = List<List<List<T>>>(listOfListsOfLists!.value)
                            tempAppendList?.next = returnList
                            returnList = tempAppendList
                            if listOfListsOfLists?.next != nil {
                                listOfListsOfLists = listOfListsOfLists?.next
                                continue
                            }
                            break
                        }
                    }
                    
                }
            }
            loopCount += 1
        }
        return returnList
    }
}
// Finished after 6-7 hours
// Wasted about 3-4 hours trying to smash the solutions to P 27 and P 26 together, to no sucess, and finally got it after scrapping everything I had done thus far and going back to the start and carefully mapping out exactly how I wanted to do it. (Still took another 3+ hours to get it working tho)


// P 28 Sorting a linked list of linked lists according to length of sublists.
extension List {
    func lsort() -> List {
        var mutatableList: List<List<String>> = self as! List<List<String>>
        var returnList = List<List<String>>(mutatableList.value)
        
        
        while mutatableList.next != nil {
            mutatableList = mutatableList.next!
            // setting up values for the loop below
            // main value i'm comparing against
            let mutatableValueLength = mutatableList.value.length
            //list to sort the returnList into
            var tempListOfList = List<List<String>>()
            // values to control when the current mutatableList.value goes into the returnList
            var previousReturnListValue = 0
            // makes sure duplicates arent put in
            var repeatStopper = 0
            for _ in 1...returnList!.length {
                // if statement to place mutaList.value if the length is less than or equal to any of the current values.length in returnList
                if  previousReturnListValue <= mutatableValueLength && mutatableValueLength <= returnList!.value.length && repeatStopper == 0{
                    let tempList = List<List<String>>(mutatableList.value)
                    tempList?.next = tempListOfList
                    tempListOfList = tempList
                    repeatStopper = 1
                }
                // setting new benchmark for minimum value
                previousReturnListValue = (returnList?.value.length)!
                let tempList = List<List<String>>(returnList!.value)
                tempList?.next = tempListOfList
                tempListOfList = tempList
                
                if returnList?.next != nil {
                    returnList = returnList?.next
                } else {
                    // if the mutaList.vale has not been added to the temp list then put it at the end
                    if repeatStopper == 0 {
                        let tempList = List<List<String>>(mutatableList.value)
                        tempList?.next = tempListOfList
                        tempListOfList = tempList
                        repeatStopper = 1
                    }
                }
            }
            returnList = tempListOfList?.reverse()
        }
        return returnList as! List<T>
    }
}
// Overall pretty simple. Took about 2 1/2 hours, but had a hard time focusing on this one for some reason so it took much longer than it should have
// I had the basic logic down in less than half an hour, the main problems I ran into were just getting duplicates and figuring out how to properly add new values to the current returnList.

