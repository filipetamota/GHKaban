//
//  NextViewController.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// ViewController that will show the issues selected for next sprint from an repo chosen by the user

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.visibleViewController?.title = "Next"
    }

}
