//
//  FindTheLastElementOfLinkedList.swift
//  99SwiftProblems
//
//  Created by William Moody on 9/6/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation

class List<T> {
    var value: T
    var nextItem: List<T>?
    
    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init?(_ values: [T]) {
        guard let first = values.first else { return nil }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }
}

extension List {
    //P01 (*) Find the last element of a linked list.
    public var last: T {
        return nextItem?.last ?? value
    }
}

extension List {
    //P02 (*) Find the last but one element of a linked list.
    public var penultimate: T? {
        guard let next = nextItem else { return nil }
        return next.penultimate ?? value
    }
}

extension List {
    //P03 (*) Find the Kth element of a linked list.
    subscript(index: Int) -> T? {
        return index == 0 ? value : nextItem?[index - 1]
    }
}

extension List {
    //P04 (*) Find the number of elements of a linked list.
    var length: Int {
        return 1 + (nextItem?.length ?? 0)
    }
}

extension List {
    //P05 (*) Reverse a linked list.
    func reverse() -> List {
        var mutatableCurrentList = self
        var reversedList = List(value)
        
        while mutatableCurrentList.nextItem != nil {
            mutatableCurrentList = mutatableCurrentList.nextItem!
            let newList = List(mutatableCurrentList.value)
            newList?.nextItem = reversedList
            reversedList = newList
        }
        return reversedList!
    }
}
