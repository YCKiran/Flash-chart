//
//  RegisterViewController.swift
//  Flash chart
//
//  Created by Chandra Kiran Reddy Yeduguri on 12/04/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // ...
                if let e = error {
                    print(e.localizedDescription)
                } else {
//                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "RegisterToChart" {
////            let destinationVC = segue.destination as! ChartViewController
//        }
//
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
