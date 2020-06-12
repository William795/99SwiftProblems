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
//        linkedListTestButtons()
//        ArithmeticTestButtons()
        logicAndCodesTest()
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
//        intExtensionTester.shared.totientTest()
//        intExtensionTester.shared.primeFactorsTest()
//        intExtensionTester.shared.primeFactorMultiplicityTest()
//        intExtensionTester.shared.totientTestImproved()
//        intExtensionTester.shared.listPrimesInRangeTest()
//        intExtensionTester.shared.goldbachTest()
//        intExtensionTester.shared.goldbachListTest()
//        intExtensionTester.shared.goldbachLimitedTest()
    }
    
    func logicAndCodesTest() {
//        print(table(expression: { and($0, or($0, $1)) }))
//        print(table(expression: { and(or($0, $1), nand($0, $1)) }))
        print(table(expression: { $0 ∧ ($0 ∨ $1) }))
        print(table(expression: { ($0 ∨ $1) ∧ ($0 ⊼ $1)}))
    }
}
