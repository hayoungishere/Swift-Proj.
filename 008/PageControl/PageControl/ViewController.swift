//
//  ViewController.swift
//  PageControl
//
//  Created by 김하영 on 2019. 3. 5..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

var images=["1.JPG","2.JPG","3.JPG","4.JPG","5.JPG"]
class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageControl.numberOfPages = images.count
        pageControl.currentPage=0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image=UIImage(named: images[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pageChanged(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
}

