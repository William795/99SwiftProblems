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
//        listTest.shared.printLastItemInList()
//        listTest.shared.printPennultimate()
//        listTest.shared.printKthElement()
//        listTest.shared.printListLength()
//        listTest.shared.printReverseList()
//        listTest.shared.printPalindromCheck()
//        listTest.shared.printFlattenNestedLinkedListStructure()
//        listTest.shared.printCompressedList()
        listTest.shared.printPackedList()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}