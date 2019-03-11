//
//  ViewController.swift
//  Navigation
//
//  Created by 김하영 on 2019. 3. 5..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,EditDelegate {
    @IBOutlet weak var txMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as!
            EditViewController
        if segue.identifier == "editButton"{
            //버튼을 클릭한 경우
            editViewController.textWayValue="segue : use button"
        }else if segue.identifier == "editBarButton"{
            //바 버튼을 클릭한 경우
            editViewController.textWayValue="segue : use Bar button"
        }
        editViewController.delegate=self
    }
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text=message
    }
}

