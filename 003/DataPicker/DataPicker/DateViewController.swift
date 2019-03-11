//
//  ViewController.swift
//  DataPicker
//
//  Created by 김하영 on 2019. 3. 3..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval=1.0
    var count=0
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:mm:ss EEE"
        lblPickerTime.text="선택시간: "+formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime(){
       // lblCurrentTime.text = String(count)
        //count=count+1
        let date=NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text="현재시간 : "+formatter.string(from: date as Date)
    }
    
    
    
}

