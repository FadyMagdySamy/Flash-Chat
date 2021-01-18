//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Fady Magdy on 18/01.2021.
//
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.welcomeToLogin, sender: self)
        
    }
    
    
    @IBAction func regesterPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.welcomeToRegester, sender: self)
    }
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
        
        
    }
    
    
}
