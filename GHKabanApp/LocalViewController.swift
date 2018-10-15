//
//  SecondViewController.swift
//  GHKabanApp
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// ViewController that will show a list of repositories selected by the user from the list showed in ExploreViewController

import UIKit

class LocalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.visibleViewController?.title = "GH Kanban"
    }
    
}

