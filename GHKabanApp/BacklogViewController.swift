//
//  BacklogViewController.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// ViewController that will show all of the issues from an repo chosen by the user

import UIKit

class BacklogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.visibleViewController?.title = "Backlog"
    }

}
