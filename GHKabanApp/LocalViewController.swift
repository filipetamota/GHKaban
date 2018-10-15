//
//  SecondViewController.swift
//  GHKabanApp
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// ViewController that will show a list of repositories selected by the user from the list showed in ExploreViewController

import UIKit

class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var tableView: UITableView!
    
    var repos: [Repo] = [Repo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.visibleViewController?.title = "GH Kanban"
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    //TODO: order local repos A-Z
    //TODO: hide tableView and show message when there is no data to put in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KabanRepoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "KabanRepoCell") as! KabanRepoTableViewCell
        cell.nameLabel?.text = self.repos[indexPath.row].name
        cell.ownerLabel?.text = self.repos[indexPath.row].owner
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getIssues(repo: repos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.repos.remove(at: indexPath.row)
            updateLocalRepos()
            self.tableView.reloadData()
        }
    }
    
    func updateLocalRepos() {
        let barViewControllers = self.tabBarController?.viewControllers
        let evc = barViewControllers![0] as! ExploreViewController
        evc.kanbanRepos = self.repos
    }
    
    //TODO: create loading indicators
    func getIssues(repo: Repo) {
        var request = URLRequest(url: URL(string: "https://api.github.com/repos/\(repo.owner)/\(repo.name)/issues")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                let jsonArray = json as! [[String:Any]]
                
                var issues: [Issue] = [Issue]()
                for jsonElement: [String: Any] in jsonArray {
                    issues.append(Issue(title: jsonElement["title"] as? String ?? "", info: jsonElement["body"] as? String ?? "", issue_id: jsonElement["id"] as? Int ?? 0))
                }
                DispatchQueue.main.async {
                    self.loadDetails(issues: issues)
                }
                
            } catch {
                //TODO: analyze the different types of error and show alert views
                print("error")
            }
        })
        
        task.resume()
    }
    
    func loadDetails(issues: [Issue]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        controller.backlog_issues = issues
        self.navigationController?.pushViewController(controller, animated: true)
    }
        
    
}


