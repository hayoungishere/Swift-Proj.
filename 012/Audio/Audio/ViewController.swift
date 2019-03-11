//
//  ViewController.swift
//  Audio
//
//  Created by 김하영 on 2019. 3. 7..
//  Copyright © 2019년 HAYOUNG_KIM. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate,AVAudioRecorderDelegate {

    var audioPlayer : AVAudioPlayer! //AVAudioPlayer 인스턴스 변수
    var audioFile : URL! //재상할 오디오의 파일명 변수
    let MAX_VOLUME : Float = 10.0 //최대볼륨
    var progressTimer : Timer! = nil //타이머를 위한 변수
    
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    
    let timeRecordSeletor : Selector = #selector(ViewController.updateRecordTime)
    
    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecordTime: UILabel!
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectAudioFile()
        //initPlay()
        if !isRecordMode{
            initPlay()
            btnRecord.isEnabled=false
            lblRecordTime.isEnabled=false
        }else{
            initRecord()
        }
    }
    
    func selectAudioFile(){
        if !isRecordMode{
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        }else{
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    func initRecord(){
        let recordSettings=[
            AVFormatIDKey: NSNumber(value:kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String : Any]
        
        do{
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        }catch let error as NSError{
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled=true
        audioRecorder.prepareToRecord()
        
        slVolume.value=1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text=convertNSTimeInterval2String(0)
        lblCurrentTime.text=convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }catch let error as NSError{
            print(" Error-setCategory : \(error)")
        }
        do{
            try session.setActive(true)
        }catch let error as NSError{
            print(" Error-setActive: \(error)")
        }
        
    }
    
    func initPlay(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        }catch let error as NSError{
        print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value=1.0
        pvProgressPlay.progress=0.0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume=slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text=convertNSTimeInterval2String(0)
        
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String{
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format : "%02d:%02d", min, sec)
        return strTime
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updatePlayTime(){
        lblCurrentTime.text=convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime=0
        lblCurrentTime.text=convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: true, stop: false)
        progressTimer.invalidate()
        
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn{
            audioPlayer.stop()
            audioPlayer.currentTime=0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode=true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        }else{
            isRecordMode=false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled=false
            lblRecordTime.text=convertNSTimeInterval2String(0)
        }
        selectAudioFile()
        if !isRecordMode{ //switch Off
            initPlay()
        }else{  //switch On
            initRecord()
        }
    }
    @IBAction func btnRecord(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record"{
            audioRecorder.record()
            sender.setTitle("Stop", for: UIControlState())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSeletor, userInfo: nil, repeats: true)
        }else{
            audioRecorder.stop()
            progressTimer.invalidate() //녹음이 중지되면 타이머를 무효화
            sender.setTitle("Record", for: UIControlState())
            btnPlay.isEnabled=true
            initPlay()
        }
    }
    @objc func updateRecordTime(){
        lblRecordTime.text=convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}

