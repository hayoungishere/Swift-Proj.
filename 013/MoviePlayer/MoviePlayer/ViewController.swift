//
//  ViewController.swift
//  MoviePlayer
//
//  Created by 김하영 on 2019. 3. 7..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        //내부 파일
        let filePath:String? = Bundle.main.path(forResource: "FastTyping", ofType: "m4v")
        let url = NSURL(fileURLWithPath: filePath!)
       
        playVideo(url: url)
    }
    
    @IBAction func btnPlayexternalMovie(_ sender: UIButton) {
        //외부파일
       
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Firesorks.mp4")
        
        playVideo(url: url!)
    }
    
    private func playVideo(url: NSURL){
        let playerContorller = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerContorller.player = player
        self.present(playerContorller, animated: true){
            player.play()
        }
    }
}

