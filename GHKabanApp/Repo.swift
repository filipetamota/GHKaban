//
//  Repo.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//

import Foundation

class Repo: NSObject, NSCoding {
    let name: String
    let owner: String
    let repo_id: Int
    
    init(name: String, owner: String, repo_id: Int) {
        self.name = name
        self.owner = owner
        self.repo_id = repo_id
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.owner = decoder.decodeObject(forKey: "owner") as? String ?? ""
        self.repo_id = decoder.decodeInteger(forKey: "repo_id")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(owner, forKey: "owner")
        coder.encode(repo_id, forKey: "repo_id")
    }
}
