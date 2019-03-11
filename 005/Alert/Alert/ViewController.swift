//
//  ViewController.swift
//  Alert
//
//  Created by 김하영 on 2019. 3. 3..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imgOn : UIImage = UIImage(named: "lamp-on.JPG")!
    let imgOff : UIImage = UIImage(named: "lamp-off.JPG")!
    let imgRemove : UIImage = UIImage(named: "lamp-remove.JPG")!
    
    var isLampOn = true

    @IBOutlet weak var lampImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        lampImg.image=imgOn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLampOn(_ sender: UIButton) {
        if(isLampOn==true){
            //전구가 켜져 있을 때
            //전구가 켜져있다고 Alert을 실행함
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 On 상태입니다", preferredStyle: UIAlertControllerStyle.alert)
            let onAction = UIAlertAction(title:"네, 알겠습니다", style: UIAlertActionStyle.default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)

        }else{
            //전구가 켜져있지 않을 때
            //전구를 켬
            lampImg.image=imgOn
            isLampOn=true
        }
    }
    
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn{
            //전구가 켜졌 있을 경우
            //전구를 끌 것인지를 묻는 Alert을 실행
            //if(isLampOn==true)를 작성해도 무방.
            let lampOffAlert = UIAlertController(title:"램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
            
            let offAction = UIAlertAction(title:"네", style: UIAlertActionStyle.default, handler:{ACTION in self.lampImg.image=self.imgOff
                self.isLampOn=false})
            
            let cancelAction = UIAlertAction(title:"아니오", style: UIAlertActionStyle.default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            
            present(lampOffAlert, animated: true, completion: nil)
        }
    }
    @IBAction func btnLampRemove(_ sender: UIButton) {
        
    }
    
}

