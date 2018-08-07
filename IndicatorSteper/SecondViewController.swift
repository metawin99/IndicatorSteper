//
//  SecondViewController.swift
//  IndicatorSteper
//
//  Created by Soemsak on 7/8/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit

protocol SecondViewControllerDelagate {
    func secondViewControllerBackButtonTapped()
}

class SecondViewController: UIViewController, PageIndexViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var pageIndex:Int!
    var delegate:SecondViewControllerDelagate?
    
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

    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.secondViewControllerBackButtonTapped()
    }
    
}
