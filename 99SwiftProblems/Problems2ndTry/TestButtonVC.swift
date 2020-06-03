//
//  MainViewController.swift
//  99SwiftProblems
//
//  Created by William Moody on 9/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func testButtonPressed(_ sender: Any) {
        linkedListTestButtons()
        ArithmeticTestButtons()
    }

    func linkedListTestButtons() {
        //        listTest.shared.printLastItemInList()
        //        listTest.shared.printPennultimate()
        //        listTest.shared.printKthElement()
        //        listTest.shared.printListLength()
        //        listTest.shared.printReverseList()
        //        listTest.shared.printPalindromCheck()
        //        listTest.shared.printFlattenNestedLinkedListStructure()
        //        listTest.shared.printCompressedList()
        //        listTest.shared.printPackedList()
        //        listTest.shared.printEncode()
        //        listTest.shared.printModifiedEncode()
        //        listTest.shared.printDecodedList()
        //        listTest.shared.printDirectEncodedList()
        //        listTest.shared.printDuplicatedList()
        //        listTest.shared.printDuplicateXTimesList()
        //        listTest.shared.printDroppedNthElementList()
        //        listTest.shared.printSplitList()
        //        listTest.shared.printListSlice()
        //        listTest.shared.printRotatedList()
        //        listTest.shared.printRotatedList()
        //        listTest.shared.printRemoveKthElementTuple()
        //        listTest.shared.printInsertAtList()
        //        listTest.shared.printRangeList()
        //        listTest.shared.extractRandomElements()
        //        listTest.shared.printLotto()
        //        listTest.shared.printPermutationList()
        //        listTest.shared.printCombinationList()
        //        listTest.shared.printPermutations()
        //        listTest.shared.printGroup3()
        //        listTest.shared.printGroupX()
        //        listTest.shared.printLSort()
//                listTest.shared.printLSortFreq()
    }
    
    func ArithmeticTestButtons() {
//        intExtensionTester.shared.primeTest()
//        intExtensionTester.shared.GCDTest()
//        intExtensionTester.shared.coPrimeTest()
        intExtensionTester.shared.totientTest()
    }
}
