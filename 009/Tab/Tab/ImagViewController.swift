//
//  ViewController.swift
//  ImageView
//
//  Created by 김하영 on 2019. 3. 2..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit

class ImagViewController: UIViewController {
    var isZoom=false
    var imgOn:UIImage?
    var imgOff:UIImage?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnResize: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgOn=UIImage(named:"DSC00281.JPG")
        imgOff=UIImage(named:"DSC00278.JPG")
        
        imgView.image=imgOn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale:CGFloat=2.0
        var newWidth:CGFloat, newHeight:CGFloat
    
        if(isZoom){ //true
            newWidth=imgView.frame.width/scale
            newHeight=imgView.frame.height/scale
            imgView.frame.size=CGSize(width: newWidth, height: newHeight)
            btnResize.setTitle("확대", for: .normal)
        }else{ //false
            newWidth=imgView.frame.width*scale
            newHeight=imgView.frame.height*scale
            imgView.frame.size=CGSize(width: newWidth, height: newHeight)
            btnResize.setTitle("축소", for: .normal)
        
        }
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn{
            imgView.image=imgOn
        } else{
            imgView.image=imgOff  
        }
    }
}

