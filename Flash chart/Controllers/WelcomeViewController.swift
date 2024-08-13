//
//  ViewController.swift
//  Flash chart
//
//  Created by Chandra Kiran Reddy Yeduguri on 12/04/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }

    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
    }
}
