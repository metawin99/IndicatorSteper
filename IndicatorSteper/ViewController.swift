//
//  ViewController.swift
//  IndicatorSteper
//
//  Created by Soemsak on 6/8/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit

protocol PageIndexViewControllerDelegate {
    func getPageIndex() -> Int!
    func setPageIndex(index:Int!)
}

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, FirstViewControllerDelagate, SecondViewControllerDelagate {
 
    @IBOutlet weak var stepView: StepView!


    var firstViewController:FirstViewController!
    var secondViewController:SecondViewController!
    weak var pageViewController : UIPageViewController!
    
    var index: Int?
    let TOTAL = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = self.childViewControllers[0] as! UIPageViewController
        self.pageViewController.dataSource = self
        
        for view in self.pageViewController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        self.firstViewController.delegate = self
        self.firstViewController.setPageIndex(index: 0)
        self.secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.secondViewController.delegate = self
        self.secondViewController.setPageIndex(index: 1)
        
        index = 0
        self.pageViewController.setViewControllers([getViewControllerAtIndex(index: index!)] as? [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getViewControllerAtIndex(index: Int) -> UIViewController? {
        if index == 0 {
            return self.firstViewController
        }else if index == 1 {
            return self.secondViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let cur = viewController as! PageIndexViewControllerDelegate
        let num = cur.getPageIndex()
        if num == 0 {
            return nil
        }
        return getViewControllerAtIndex(index: num! - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let cur = viewController as! PageIndexViewControllerDelegate
        let num = cur.getPageIndex()
        if num == TOTAL {
            return nil
        }
        return getViewControllerAtIndex(index: num! + 1)
    }
    
     //Mark - : FirstViewControllerDelagate
    
    func firstViewControllerNextButtonTapped() {
        self.pageViewController.setViewControllers([getViewControllerAtIndex(index: 1)] as? [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            stepView.currentStep += 1
    }
    
    //Mark - : SecondViewControllerDelagate
    
    func secondViewControllerBackButtonTapped() {
        self.pageViewController.setViewControllers([getViewControllerAtIndex(index: 0)] as? [UIViewController], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
            stepView.currentStep -= 1
    }
    

}

