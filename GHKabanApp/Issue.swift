//
//  Issue.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//

import Foundation

class Issue: NSObject, NSCoding {
    let title: String
    let info: String
    let issue_id: Int
    
    init(title: String, info: String, issue_id: Int) {
        self.title = title
        self.info = info
        self.issue_id = issue_id
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.info = decoder.decodeObject(forKey: "info") as? String ?? ""
        self.issue_id = decoder.decodeInteger(forKey: "issue_id")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(info, forKey: "info")
        coder.encode(issue_id, forKey: "issue_id")
    }
}
