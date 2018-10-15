//
//  FirstViewController.swift
//  GHKabanApp
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// ViewController that will be the initial one and will show a list of repositories

import UIKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var repos: [Repo] = [Repo]()
    var kanbanRepos: [Repo] = [Repo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
        
        getRepos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.visibleViewController?.title = "GH Kanban"
        self.tableView.reloadData()
    }
    
    //TODO: create loading indicators
    func getRepos() {
        //TODO: allow the user to insert the user name
        var request = URLRequest(url: URL(string: "https://api.github.com/users/inqbarna/repos")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                let jsonArray = json as! [[String:Any]]
                self.repos.removeAll()
                for jsonElement: [String: Any] in jsonArray {
                    self.repos.append(Repo(name: jsonElement["name"] as? String ?? "", owner: (jsonElement["owner"] as! [String: Any])["login"] as? String ?? "", repo_id: jsonElement["id"] as? Int ?? 0))
                }
                self.updateLocalRepos()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } catch {
                //TODO: analyze the different types of error and show alert views
                print("error")
            }
        })
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    //TODO: hide tableView and show message when there is no data to put in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as! RepoTableViewCell
        cell.nameLabel?.text = self.repos[indexPath.row].name
        cell.ownerLabel?.text = self.repos[indexPath.row].owner
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.addButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(addKabanRepo), for: .touchUpInside)
        if (self.kanbanRepos.contains(repos[indexPath.row])) {
            cell.addButton.setImage(UIImage(named: "ic_remove"), for: .normal)
        } else {
            cell.addButton.setImage(UIImage(named: "ic_add"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func addKabanRepo(sender: UIButton!) {
        if (kanbanRepos.contains(repos[sender.tag])) {
            if let index = kanbanRepos.index(of:repos[sender.tag]) {
                kanbanRepos.remove(at: index)
            }
        } else {
            kanbanRepos.append(repos[sender.tag])
        }
        updateLocalRepos()
        self.tableView.reloadData()
    }
    
    //TODO: save on NSUserDefaults the local repos so next time the same ones will be loaded
    func updateLocalRepos() {
        let barViewControllers = self.tabBarController?.viewControllers
        let lvc = barViewControllers![1] as! LocalViewController
        lvc.repos = self.kanbanRepos
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(handleRefresh),for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    @objc func handleRefresh() {
        self.getRepos()
    }
}
