//
//  PageViewController.swift
//  LINES
//
//  Created by david crabtree on 7/26/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "SecondVC")]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        if let firstVC = VCArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return VCArray.last
        }
        
        guard VCArray.count > previousIndex else {
            return nil
            
        }
        
        return VCArray[previousIndex]
        
    }
    

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else {
            return nil
            
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArray.count else {
            return VCArray.first
        }
        
        guard VCArray.count > nextIndex else {
            return nil
        }
        
        return VCArray[nextIndex]
    
    }
    

    
     public func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        // The number of items reflected in the page indicator.
        
        return VCArray.count
    }
    
    

     public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // The selected item reflected in the page indicator.
        
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCArray.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
        
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


