//
//  ViewController.swift
//  PickerView
//
//  Created by 김하영 on 2019. 3. 3..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate {
    let MAX_ARRAY_NUM=6
    let PICKER_VIEW_COLUMN=1
    var imageFileName=["1.JPG","2.JPG","3.JPG","4.JPG","5.JPG","6.JPG"]
    
    @IBOutlet weak var pickerImage: UIPickerView!
    @IBOutlet weak var lblImageFileName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return PICKER_VIEW_COLUMN
    }
    
    //returns the # of rows in each component...
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{return imageFileName.count}

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return imageFileName[row]
    }
}

