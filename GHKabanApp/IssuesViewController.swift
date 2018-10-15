//
//  BacklogViewController.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// ViewController that will show all of the issues from an repo chosen by the user

import UIKit

class IssuesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var pageViewController: PageViewController?
    
    var type: String?
    var issues: [Issue] = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //TODO: save board state in NSUserDefaults
    override func viewDidAppear(_ animated: Bool) {
        pageViewController = self.parent as? PageViewController
        switch type {
        case "Backlog":
            issues = pageViewController?.backlog_issues ?? [Issue]()
            break
        case "Next":
            issues = pageViewController?.next_issues ?? [Issue]()
            break
        case "Doing":
            issues = pageViewController?.doing_issues ?? [Issue]()
            break
        case "Done":
            issues = pageViewController?.done_issues ?? [Issue]()
            break
        case .none:
            break
        case .some(_):
            break
        }
        navigationController?.visibleViewController?.title = type
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    //TODO: order issues A-Z and add right and left arrow icons
    //TODO: hide tableView and show message when there is no data to put in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IssueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueCell") as! IssueTableViewCell
        cell.titleLabel?.text = issues[indexPath.row].title
        cell.infoLabel?.text = issues[indexPath.row].info
        
        cell.moveLeft.tag = indexPath.row
        cell.moveLeft.addTarget(self, action: #selector(moveLeft), for: .touchUpInside)
        cell.moveRight.tag = indexPath.row
        cell.moveRight.addTarget(self, action: #selector(moveRight), for: .touchUpInside)
        
        if type == "Backlog" {
            cell.moveLeft.isHidden = true
        }
        if type == "Done" {
            cell.moveRight.isHidden = true
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func moveLeft(sender: UIButton!) {
        switch type {
        case "Next":
            let issue: Issue = issues[sender.tag]
            pageViewController?.backlog_issues.append(issue)
            pageViewController?.next_issues.remove(at: sender.tag)
            issues = pageViewController?.next_issues ?? [Issue]()
            self.tableView.reloadData()
            break
        case "Doing":
            let issue: Issue = issues[sender.tag]
            pageViewController?.next_issues.append(issue)
            pageViewController?.doing_issues.remove(at: sender.tag)
            issues = pageViewController?.doing_issues ?? [Issue]()
            self.tableView.reloadData()
            break
        case "Done":
            let issue: Issue = issues[sender.tag]
            pageViewController?.doing_issues.append(issue)
            pageViewController?.done_issues.remove(at: sender.tag)
            issues = pageViewController?.done_issues ?? [Issue]()
            self.tableView.reloadData()
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    @objc func moveRight(sender: UIButton!) {
        switch type {
        case "Backlog":
            let issue: Issue = issues[sender.tag]
            pageViewController?.next_issues.append(issue)
            pageViewController?.backlog_issues.remove(at: sender.tag)
            issues = pageViewController?.backlog_issues ?? [Issue]()
            self.tableView.reloadData()
            break
        case "Next":
            let issue: Issue = issues[sender.tag]
            pageViewController?.doing_issues.append(issue)
            pageViewController?.next_issues.remove(at: sender.tag)
            issues = pageViewController?.next_issues ?? [Issue]()
            self.tableView.reloadData()
            break
        case "Doing":
            let issue: Issue = issues[sender.tag]
            pageViewController?.done_issues.append(issue)
            pageViewController?.doing_issues.remove(at: sender.tag)
            issues = pageViewController?.doing_issues ?? [Issue]()
            self.tableView.reloadData()
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    

}
