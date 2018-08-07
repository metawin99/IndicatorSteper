//
//  FirstViewController.swift
//  IndicatorSteper
//
//  Created by Soemsak on 7/8/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit

protocol FirstViewControllerDelagate {
    func firstViewControllerNextButtonTapped()
}

class FirstViewController: UIViewController, PageIndexViewControllerDelegate {
   
    @IBOutlet weak var scrollView: UIScrollView!
    
    var pageIndex:Int!
    var delegate:FirstViewControllerDelagate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.isScrollEnabled = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPageIndex() -> Int! {
        return pageIndex
    }
    
    func setPageIndex(index: Int!) {
        pageIndex = index
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        delegate?.firstViewControllerNextButtonTapped()
    }
    
}
