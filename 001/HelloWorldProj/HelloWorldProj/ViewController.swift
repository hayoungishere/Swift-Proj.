//
//  ViewController.swift
//  HelloWorldProj
//
//  Created by 김하영 on 2019. 3. 2..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHello: UILabel!

    @IBOutlet weak var txtName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text="Hello,"+txtName.text!
    }
    
}

