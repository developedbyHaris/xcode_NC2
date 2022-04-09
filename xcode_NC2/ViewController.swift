//
//  ViewController.swift
//  xcode_NC2
//
//  Created by Rajabul Haris on 11/04/21.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {
    
    var startShaking = false
    var endShaking = false
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var landingImage: UIImageView!
    @IBOutlet weak var shakeProgress: ProgressBar!
    @IBOutlet weak var landingLabel: UILabel!
    
    
    var whatToEat: [String] = ["Ayam Bakar Taliwang", "Ayam Penyet Komplit", "Ayam Tepung Teri", "Ayam Bakar Asam Manis Pedas", "Bubur Ayam 3", "Bubur Ayam 2", "Bubur Ayam", "Epok-epok", "Gulai Rebung", "Ikan Asin Sayur Kangkung", "Lontong Gulai", "Lontong Gulai 2", "Lontong Pecel Dadar", "Mie Pangsit Bakso", "Mie Tarempa", "Nasi Padang Ayam Dendeng", "Nasi Padang Ayam Gulai", "Nasi Padang Dendeng", "Nasi Padang Rendang", "Opor Ayam", "Pecel Lele", "Pepes Ikan", "Roti Selai Bubur Pelangi", "Sate Danging", "Sate Padang 2", "Sate Padang", "Sate", "Sop Tulang", "Soto Ayam Jumbo", "Soto Daging", "Soto Padang", "Soto"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startButton.layer.cornerRadius = 8
        landingImage.layer.cornerRadius = 8
        landingLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        landingLabel.numberOfLines = 0
        landingLabel.textAlignment = .center
        landingImage.shake(1000)
    
        self.becomeFirstResponder()
    
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    
    // Enable detection of shake motion
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if startShaking {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if startShaking {
            landingLabel.text = "Keep shake it up!"
            if motion == .motionShake {
                print("Why are you shaking me?")
                if self.shakeProgress.progress < 0.8{
                    self.shakeProgress.progress += 0.20
                    shakeProgress.shake()
                   
                    
                }else if self.shakeProgress.progress == 0.8{
                    self.shakeProgress.progress += 0.16
                    shakeProgress.shake()
                    
                    
                }else{
                    let shuffledFood =  whatToEat.shuffled()
                    self.shakeProgress.progress = 1
                    endShaking = true
                    startShaking = false
                    startButton.setTitle("Close", for: .normal)
                    startButton.isHidden = false
                    landingLabel.text = shuffledFood[0]
                
                    
                    shakeProgress.isHidden = true
                    landingImage.isHidden = false
                    landingImage.contentMode = .scaleToFill
                    landingImage.image = UIImage(named: shuffledFood[0])
                    landingImage.layer.borderWidth = 24
                    landingImage.layer.borderColor = UIColor.white.cgColor
                    landingImage.shake()

                }
            }
            
        }
        else {
            print("Ngk getar, geli-geli aja")
        }
    }
 
    
    @IBAction func startAction(_ sender: Any) {
//        startShaking = true
        if endShaking {
            self.shakeProgress.progress = 0
            startShaking = false
            endShaking = false
            landingImage.isHidden = false
            shakeProgress.isHidden = true
//            startButton.setTitle("Let's shake it up!", for: .normal)
            startButton.setTitle("Shake again?", for: .normal)
            landingLabel.text = "Shake your phone to get suggestion"
            landingImage.image = UIImage(named: "shake")
            landingImage.layer.borderWidth = 0
            landingImage.contentMode = .scaleAspectFit
            landingImage.shake(1000)
        }else{
           
            startShaking = true
            landingImage.isHidden = true
            shakeProgress.isHidden = false
            startButton.isHidden = true
            
        }
    }
    
    
    
}

extension UIView {
    func shake(_ repeatCount: Float? = 1) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 2
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        animation.repeatCount = repeatCount ?? 1
        layer.add(animation, forKey: "shake")
    }
}
