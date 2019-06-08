//
//  ViewController.swift
//  OmikujiApp
//
//  Created by Kaoru Tsugane on 2019/06/08.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit

//音楽を鳴らすプログラムを追加する
//記述することで、各機能のライブラリ（特定の機能や用途をまとめたもの）をプログラム内で使えるようになります。
import AVFoundation


class ViewController: UIViewController {
    //結果の時の音
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    //降っている時の音
    var playingAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    
    
    //Viewから紐づけ
    @IBOutlet weak var stickView: UIView!
    //Labelから紐づけ
    @IBOutlet weak var stickLabel: UILabel!
    //制約から紐づけ
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    //制約から紐づけ
    @IBOutlet weak var stiskBottomMargin: NSLayoutConstraint!
    
    //おみくじの内容を格納する定数
    let resultTexts: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //音の準備
        setupSound()
        //音二つ目の準備
        playingSound()
        // Do any additional setup after loading the view.
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //ふっている時に音を再生(Play)する！
        self.playingAudioPlayer.play()
        
        //結果表示中はモーションを無効にする
        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false {
            return
        }

        
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        //結果表示中はモーションを無効にする
        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false {
            return
            
        }
    
        
        
        
        
        //resultTextsの数（７個）を
        //UInt32という型に変換する
        //arc4random_uniform（ランダム関数）を使う
        //最後にもう一度Int型に直してあげる感じ
        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
        
        if stiskBottomMargin.constant == CGFloat(0){
            stickLabel.text = resultTexts[resultNum]
        }else{
            return
        }
        

     
        
//       stickLabel.text = resultTexts[resultNum]
        
        
//            stickLabel.text = resultTexts[resultNum]
        
        
      
        
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            self.stickLabel.text = self.resultTexts[resultNum]
//        }
        
        

        
        
        //紐付けた制約の変数.constantで数値を取ることができます。
        //おみくじ棒の下の値に、おみくじ棒の上辺をマイナスした値を入れている
        stiskBottomMargin.constant = stickHeight.constant * -1
        //一秒間の間にどんなアニメーションをするかを記述している
        UIView.animate(withDuration: 1.0, animations: {
            //必要になった時にいいようにアニメーションを調節してくれるのがここ
            //制約でアニメーションをつけるのであれば、ここをかく。
            self.view.layoutIfNeeded()
            
        }, completion: { (finished: Bool) in
            // 結果のViewを表示させる
            self.bigLabel.text = self.stickLabel.text
            self.overView.isHidden = false
            //結果表示のときに音を再生(Play)する！
            self.resultAudioPlayer.play()
            //結果発表時に振っている音を止める
            self.playingAudioPlayer.stop()
            
            
        })
        
        
        
        
    }
    
    //リセットボタンの実装

    
    @IBAction func tapRetryButton(_ sender: UIButton) {
        overView.isHidden = true
        stiskBottomMargin.constant = 0
    }
    
    
    
    
    //結果表示するときに鳴らす音の準備
    func setupSound(){
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3"){
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
    
    //ふっているときに鳴らす音の準備
    func playingSound(){
        if let sound = Bundle.main.path(forResource: "bell", ofType: ".mp3"){
            playingAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            playingAudioPlayer.prepareToPlay()
        }
    }
    
    
    
    
    @IBOutlet weak var overView: UIView!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    
    
    
    


}

