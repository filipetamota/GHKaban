//
//  PageViewController.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//
// PageViewController that will control the 4 ViewControllers (Backlog, Next, Doing and Done). The 4 ViewControllers will show the issues from an repo chosen by the user

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var backlog_issues: [Issue] = [Issue]()
    var next_issues: [Issue] = [Issue]()
    var doing_issues: [Issue] = [Issue]()
    var done_issues: [Issue] = [Issue]()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pageViewControllers.count > previousIndex else {
            return nil
        }
        
        return pageViewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = pageViewControllers.count
        
        guard viewControllersCount != nextIndex else {
            return nil
        }
        
        guard viewControllersCount > nextIndex else {
            return nil
        }
        
        return pageViewControllers[nextIndex]
    }
    
    //set is private, but get is public
    //lazy so it's not calculated until the first time is used, so the func newViewController will be called before
    private(set) lazy var pageViewControllers: [UIViewController] = {
        
        return [self.newViewController(key: "Backlog"),
                self.newViewController(key: "Next"),
                self.newViewController(key: "Doing"),
                self.newViewController(key: "Done")] as [UIViewController]
    }()
    
    private func newViewController(key: String) -> UIViewController {
        
        let controller: IssuesViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IssuesViewController") as! IssuesViewController
        controller.type = key
        return controller
    }
    
    
    //TODO: get issues and pass them to the page view controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let firstViewController = pageViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }

}
